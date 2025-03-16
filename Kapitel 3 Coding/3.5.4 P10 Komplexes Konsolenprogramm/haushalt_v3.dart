import 'dart:developer';
import 'dart:io';
import 'lib/haushalt_libs.dart';
import 'lib/src/ansi.dart';

bool notSaved = false;
// List<dynamic> Entries = [];
Bookings haushalt = Bookings();
// Map<String, Map<String, dynamic>> Entries = {"Entries":{}}; // Test als mögliche Lösung für korrektes Json-Laden
int entriesPerPage = 10;
Terminal term = Terminal();

/**
 * Haushaltbuchführung als Konsolenprogramm
 * V3 mit kaufmännischer Buchhaltung (T-Konto, Soll/Haben, Übertrag)
 * (C) 2025 by Microwalker
 * ========================================
 * Bitte in einem Terminalfenster ausführen!
 *
 * Unterschiede zu V2:
 * - Alle Funktionen für die Ein- und Ausgabe über das Terminal sind in die terminal-Klasse (terminal.dart) ausgelagert
 * - Alle Datensatzspezifischen Funktionen sind in die Bookings-Klasse (data.dart) ausgelagert, die nun auch die Daten selbst verwaltet
 * - Die Einträge haben den Datentyp "Entry", die Liste mit diesen Einträgen den Datentyp "Entries"
 * - Diese Datei ("haushalt_v3.dart") kümmert sich nur noch um
 *   - main als Startfunktion mit Parameter-Auswertung (inkl. Hilfe) für Konsolenausführung
 *   - die Bedienung und deren Steuerung
 *   - dem Datenmanagement in der Bookings-Klasse
 *   - der Steuerung der Ein- und Ausgaben über die Terminal-Klasse
 *   - Integration meiner ANSI-Library für formatierte, farbige Ausgaben
 * 
 * VIEL SPASS BEIM AUSPROBIEREN!
 * 
 * PS: Falls Verwendungsmöglichkeiten bestehen, darf das Programm gerne selbst genutzt werden :-)
 */

void main(List<String> args) {

  // ggf. eingegebene Konsolenargumente prüfen
  if(args.isNotEmpty) {
    checkConsoleArgs(args);
  } 

  // term.terminalFrom(_out, _in);  // später auf externes Terminal umleiten !!!
  
  // Prüfen, ob das Programm in einem Terminal gestartet wurde
  if(!term.checkTerminal(true)) return;
  
  // if(!term.hasTerminal) {
  //   term.lineOut("Bitte starten Sie die Haushaltsbuchführung in einem Terminalfenster um Eingaben zu ermöglichen!");
  //   return;
  // }

  // Erstmalige Ausgabe des Hauptmenüs
  term.printTerminalMenu();

  // Verarbeitung der Eingaben mit Rückkehr zum Hauptmenü
  // Um das Programm zu verlassen (mit "E") gibt getChoices true zurück!
  while(!getChoices()) {
    term.printTerminalMenu();
  }

  // Abschied nehmen fällt schwer...
  term.cls();
  term.lineOut("\nAuf Wiedersehen!");
}

/**
 * prüft auf eventuell vorhandene Eingaben von Parametern beim Programmaufruf
 */
void checkConsoleArgs(List<String> args) {
    switch(args[0]) {
      case "help":
        term.lineOut("Optionen:\n help - zeigt diese Hilfe an\n load <Optional: dateiname.json> - lädt eine zuvor gespeicherte Datei mit Buchungsdaten" +
              "\n list <Optioal: dateiname.json> - zeigt alle Buchungen einer gespeicherten Datei an und verläßt dann das Programm\n info - zeigt " +
              "einen kleinen Infotext zum und über das Program\nOhne Angabe des optionalen Dateinamens werden Sie zur Eingabe aufgefordert!\nOhne Parameter " +
              "wird das Programm ohne bzw. zum Erstellen einer leeren Buchungsliste geöffnet!");
        exit(0);
      case "load":
        if(!load(filename: (args.length > 1 ? args[1] : null), withoutBackToMenu: true))
          exit(-1);
      case "list":
        if(load(filename: (args.length > 1 ? args[1] : null), withoutBackToMenu: true))
          listEntries(withoutBackToMenu: true, paged: false);
        exit(0);
      case "info":
        infos(withoutBackToMenu: true);
        exit(0);
      default:
        term.lineOut("Unbekannte Parameter! Verwenden Sie 'help' um sich die Hilfe anzeigen zu lassen.");
        exit(-1); // Verlassen mit Fehlercode
    }
}

/**
 * Auf Eingabe im Hauptmenu reagieren
 * HINWEIS: Speichern und Laden wurde vorerst deaktiviert. Speichern funktioniert, Laden - eigentlich - auch, es gibt aber ein
 * Problem mit den Datentypen (List<Map<String, dynamic>> != Map<String, dynamic> beim Laden mit jsondecode...)
 */
bool getChoices() {
  bool shouldEnd = false;
  
  String option = term.input("Ihre Auswahl:");
  if(option.length>0)
    switch(option[0].toUpperCase()) {
      case "1": addEntry();
      case "3": deleteEntry();
      case "4": listEntries();
      case "5": changePagesize();
      case "2": searchEntry();
      case "D": sortEntries();
      case "S": saveAll();
      case "L": load();
      case "I": infos();
      case "P": listEntries(paged: false);
      case "E" || "X": 
        shouldEnd = true;
        if(notSaved) {
          term.lineOut("${term.red+term.blink}Sie haben Änderungen vorgenommen, die noch nicht gespeichert wurden!${term.reset}");
          if(term.input("Wollen Sie das Programm trotzdem verlassen (j/n)") != "j") { shouldEnd = false; }
        }
      default:
        term.invalidInput();
    } else {
      term.invalidInput();      
    }
  return shouldEnd;
}

/**
 * Funktion zum Anlegen eines neuen Eintrags
 * Neue Einträge werden am Ende der Liste angehängt und dann wieder alle Einträge neu nach Datum sortiert.
 * Zudem besteht die Möglichkeit, mehrere Einträge nacheinander vorzunehmen.
 */
bool addEntry() {
  Entry newEntry = emptyEntry; // oder auch möglich: haushalt.empty();
  // Map<String, dynamic> newEntry = {"Datum":null, "Text":null, "Soll":null, "Haben":null};

  term.lineOut("\nBitte geben Sie nun die Daten des Vorgangs nacheinander ein.\nNach Eingabe des Betrags können Sie wählen, "+
                "ob es sich um eine Einnahme oder eine Ausgabe handelt.\nEine leere Eingabe des Datums bricht den Erfassungsvorgang ab.");
  
  bool added = true;
  try {
    String datum = "";
    while(DateTime.tryParse(datum.split(".").reversed.join("-"))==null) {
      datum = term.input("Datum (dd.mm.jjjj)");
      
      // Abbruch bei ungewollter Eingabe ermöglichen
      if(datum=="") {     
        term.input("Return um zum Hauptmenue zurückzukehren...");
        return false;
      }

      datum = haushalt.formatDate(datum);
    }
    newEntry["Datum"] = datum; // vorher Datetime, jetzt als String, da Datetime nicht als json-Datentyp akzeptiert wurde !!!
    newEntry["Text"] = term.input("Beschreibung des Vorgangs");
    
    double? betrag = null;
    while(betrag == null) {
      String input = term.input("Betrag");
      if(input == "") return false;
      
      betrag = double.tryParse(input.replaceAll(",", "."));
      if(betrag == null || betrag < 0) {
        term.lineOut("${term.red+term.blink}Betrag ungültig oder negativ. Bitte erneut eingeben oder Return zum Abbruch!${term.reset}");
      }
    }
    
    String input = "";
    while(input != "e" && input != "a" && input.toLowerCase() != "x") {
      if(input.toLowerCase() == "x") return false;
      input = term.input("[E]innahme oder [A]usgabe ([X] bricht den Eingabevorgang ab)").toLowerCase();
    }
    newEntry["Soll"] = input == "e" ? betrag : 0.0;
    newEntry["Haben"] = input == "a" ? betrag : 0.0;

    if(!newEntry.containsValue(null)) {
      haushalt.add(newEntry);
      haushalt.sortByDate();
      term.lineOut("Es wurde dieser Eintrag hinzugefügt:");
      term.printBookingsEntry(haushalt.entries.indexOf(newEntry), newEntry);

      notSaved = true;
    } else {
      throw ArgumentError("Mindestens eine Eingabe war nicht korrekt. Bitte wiederholen!");
    }
  } 
  catch(e) {
    term.lineOut("${term.red}Fehler: $e, Eintrag konnte nicht hinzugefügt werden! Bitte wiederholen...${term.reset}");
    added = false;
  }

  if(term.input("Wollen Sie gleich einen weiteren Eintrag vornehmen (j/n)")!="j") {
    term.input("Return um zum Hauptmenue zurückzukehren...");
    return added;
  }

  return addEntry();
}


/**
 * Sortieren aller Einträge nach Datum
 */
void sortEntries() {
  term.lineOut("Alle Einträge werden erneut nach Datum sortiert!");
  haushalt.sortByDate();
  term.input("Return um zum Hauptmenue zurückzukehren...");
}

/**
 * Löschen eines Eintrags über seine Index-Nummer
 */
bool deleteEntry() {
  if(haushalt.length>0) {
    term.lineOut("Zum Löschen eines Eintrages wird die Nummer des Eintrags benötigt.");
    if(term.input("Soll die Liste einmal zur Ermittlung der Nummer ausgegeben werden (j/n)").toLowerCase()=="j") {
      listEntries(withoutBackToMenu: true);
    }
    String input = term.input("Bitte die Nummer des zu löschenden Eintrags eingeben (nur Return = Abbruch)");
    if(input != "") {
      int nr = int.tryParse(input) ?? -1;
      if(nr>=0 && nr<haushalt.length) {
        term.lineOut("Dieser Eintrag wurde zu Ihrer Eingabe gefunden:");
        term.printBookingsEntry(nr, haushalt.getEntry(nr));
        if(term.input("${term.red}Soll dieser Eintrag gelöscht werden")=="j") {
          haushalt.remove(haushalt.entries[nr]);
          term.lineOut("${term.green}Der gewünschte Eintrag wurde entfernt.");
          notSaved = true;
        }
      }
    }
  } else { 
    term.lineOut("${term.red}Es gibt keine Einträge, also kann auch kein Eintrag gelöscht werden!"); 
  }
  term.input("Return um zum Hauptmenue zurückzukehren...");
  return false;
}

/**
 * paginierte Auflistung aller eingegebenen Einträge (den bekannten Möglichkeiten des Terminals entsprechend formatiert)
 * und automatischer Saldenbildung nach den (nach Datum sortierten) Einträgen...
 */
void listEntries({bool withoutBackToMenu = false, bool paged = true}) {
  if(haushalt.length>0) {
    term.printTerminalEntries(haushalt, entriesPerPage, paged);
  } else { 
    term.lineOut("${term.red}Keine Einträge vorhanden!");
  }
  if(!withoutBackToMenu) {
    term.input("Return, um zum Hauptmenue zurückzukehren...");
  }
}


/**
 * Möglichkeit, die Anzahl der anzuzeigenen Einträge bei der Auflistung pro "Seite" zu verändern
 */
void changePagesize() {
  term.lineOut("\nBitte geben Sie hier an, wieviele Einträge pro Seite beim Auflisten angezeigt werden sollen! (return = keine Änderung)");
  String input = term.input("Wieviele Einträge sollen pro Seite aufgelistet werden (aktuell: $entriesPerPage)");
  if(input!="") {
    entriesPerPage = int.tryParse(input) ?? entriesPerPage;
  }
  term.lineOut("Ab jetzt werden beim Auflisten von Einträgen pro Durchlauf (max.) $entriesPerPage Einträge angezeigt.");
  term.input("Return, um zum Hauptmenue zurückzukehren...");
}

/**
 * Textsuche in der Eintragsbezeichnung der Einträge
 */
void searchEntry() {
  term.cls();
  term.lineOut("${term.green}Ihnen steht eine Volltextsuche innerhalb der Vorgangsbeschreibung zur Verfügung:\n");
  String input = term.input("Nach welchem Text soll gesucht werden (unabhängig von Groß- und Kleinschreibung)");
  term.printBookingsHeader();
  haushalt.searchText(input).forEach((element) { term.printBookingsEntry(haushalt.indexOf(element), element); });
  
  term.input("\nReturn, um zum Hauptmenue zurückzukehren...");
}

/**
 * Speicherung der Daten im json-Format (Funktioniert auch...)
 */
bool saveAll() {
  String fn = term.input("Bitte Dateinamen angeben (.json wird - falls nicht angegeben - automatisch angehängt)");

  try {
    if(haushalt.saveToJson(fn)) {
      term.lineOut("${term.green}Speicherung erfolgreich!\n");
      term.input("Return, um zum Hauptmenue zurückzukehren..."); }
  } catch(e) {
    term.lineOut("${term.red}Speichern fehlgeschlagen: $e");
    notSaved = true;
    return false;
  }

  notSaved = false;
  return true;
}

/**
 * Laden der Daten aus json-Datei 
 * (Probleme bei Typumwandlung von Map<String, dynamic> zu List<Map<String, dynamic>>, daher werden die Daten
 * als List<dynamic> geladen und die Einträge von dort in die List<Map<>> kopiert)
 */
bool load({String? filename = null, bool withoutBackToMenu = false}) {
  filename = filename ?? term.input("Bitte Dateinamen angeben (.json wird - falls nicht angegeben - automatisch angehängt)");

  bool loaded = true;
  try {
    if(haushalt.loadFromJson(filename))
      term.lineOut("${term.green}Daten wurden erfolgreich geladen!");
  } 
  catch(e) { 
    term.lineOut("${term.red}Fehler beim Laden: $e");
    loaded = false;
  }
  
  if(!withoutBackToMenu)
    term.input("Return, um zum Hauptmenue zurückzukehren...");

  notSaved = false;
  return loaded;
}

void infos({bool withoutBackToMenu = false}) {
  term.printTerminalInfo();

  if(!withoutBackToMenu) {
    term.input("Return um zum Hauptmenue zurückzukehren");
  }
}