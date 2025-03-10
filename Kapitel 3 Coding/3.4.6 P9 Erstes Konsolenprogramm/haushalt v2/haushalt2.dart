import 'dart:io';
import 'dart:convert';

bool notSaved = false;
List<dynamic> Entries = [];
// Map<String, Map<String, dynamic>> Entries = {"Entries":{}}; // Test als mögliche Lösung für korrektes Json-Laden
int entriesPerPage = 10;

/**
 * Haushaltbuchführung als Konsolenprogramm
 * V2 mit kaufmännischer Buchhaltung (T-Konto, Soll/Haben, Übertrag)
 * (C) 2025 by Microwalker
 * ========================================
 * Bitte in einem Terminalfenster ausführen!
 * 
 * PS an die Tuts zur Abgabe:
 * Auch wenn nicht alle möglichen Fehleingaben
 * und sonstige Fehlerquellen abgefangen werden, 
 * sollte das hier wohl mehr als genug für 
 * "mein erstes Konsolenprogramm" sein...
 * 
 * Verwendete Stile/Methoden/Techniken etc.:
 * - globale und lokale Variablen
 * - dynamische Listen und Maps
 * - Parameter über Konsole bei Programmstart (mit opt. Hilfe-Ausgabe)
 * - Switch- und if-/if-else-Abfragen
 * - Ein- und Ausgaben im Terminal (formatiert falls erfordlich)
 * - konditionale Programmbeendigung
 * - Funktionsaufrufe mit/ohne Parameter und mit/ohne Rückgabewerte
 * - Abfangen ungültiger Eingaben
 * - Errorhandling mit try-catch und Exceptions
 * - Prüfung bei Programmende noch ungespeicherte Daten vorhanden sind
 * - Datumseingabe ohne führende Nullen und zweistelliger Jahreszahl möglich
 * - Eingabe des Betrags mit Punkt oder Komma möglich
 * - erneute Eingabemöglichkeit bei fehlerhaften Eingaben
 * - Möglichkeit, mehrere Einträge nacheinander hinzuzufügen
 * - Möglichkeit, den Eingabevorgang abzubrechen
 * - Datumskonvertierung zur Verwendung als DateTime-Datentyp (z.B. zur Sortierung nach Datum)
 * - Sortierung der Einträge nach Datum zur korrekten Saldenbildung
 * - paginierte (nach frei einstellbarer Anzahl an Einträgen pro Seite) und formatierte Ausgabe i.F. einer Tabelle mit Saldenberechnung und SOLL/HABEN-Übertrag bzw. -Abschluss
 * - Platform-Erkennung und Processaufruf im Terminal (bzw. Powershell in Windows, Anm.: cls wird in Windows nicht auf dem integr. Dartterminal ausgeführt!)
 * - Nutzung von LINQ und Lamdas in Dart
 * - Speichern und Laden der angelegten Einträge als json-Datei mit Zugriff auf das Dateisystem und dart:convert (früher separates Package)
 * - Non-Casesensitive Volltextsuche in den Einträgen
 * - Alle Ein- und Ausgaben über std-Stream (i.d.R. dem Terminal), Eingaben erfolgen i.d.R. in der selben Zeile wie dessen Aufforderung
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

  // Prüfen, ob das Programm in einem Terminal gestartet wurde
  if(!stdout.hasTerminal) {
    stdout.writeln("Bitte starten Sie die Haushaltsbuchführung in einem Terminalfenster um Eingaben zu ermöglichen!");
    return;
  }

  // Erstmalige Ausgabe des Hauptmenüs
  printMenu();

  // Verarbeitung der Eingaben mit Rückkehr zum Hauptmenü
  // Um das Programm zu verlassen (mit "E") gibt getChoices true zurück!
  while(!getChoices()) {
    printMenu();
  }

  // Abschied nehmen fällt schwer...
  cls();
  stdout.writeln("\nAuf Wiedersehen!");
}

/**
 * prüft auf eventuell vorhandene Eingaben von Parametern beim Programmaufruf
 */
void checkConsoleArgs(List<String> args) {
    switch(args[0]) {
      case "help":
        stdout.writeln("Optionen:\n help - zeigt diese Hilfe an\n load <Optional: dateiname.json> - lädt eine zuvor gespeicherte Datei mit Buchungsdaten" +
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
        stdout.writeln("Unbekannte Parameter! Verwenden Sie 'help' um sich die Hilfe anzeigen zu lassen.");
        exit(-1); // Verlassen mit Fehlercode
    }
}

/**
 * Ausgabe des Hauptmenüs auf "gecleantem" Terminal
 */
void printMenu() {
  List<String> menuOptions = [
    " 1 - Neue Einträge erfassen",
    "  2 - Einträge suchen",
    "   3 - einen Eintrag löschen",
    "    4 - Alle Einträge ausflisten",
    "     5 - Anzahl Elemente pro Seite ändern (für Ausgabe)",
    /* " D - Alle Einträge (erneut) nach Datum sortieren", */ // Nicht notwendig, da automatisch bei Erfassung von Einträgen
    " S - als Datei Speichern",
    "  L - gespeicherte Datei Laden",
    "   I - Infos zum Programm",
    " E (oder X) - Programm beenden","\n"];

  cls();
  stdout.writeln("💰 Willkommen zur Haushaltsbuchführung!\n\nBitte wählen Sie eine der folgenden Optionen:");
  stdout.writeAll(menuOptions, "\n");
}

/**
 * Terminalinhalt löschen
 */
cls() {
  // Guter Tipp von https://github.com/dart-lang/sdk/issues/48953 !!!
  stdout.write(Process.runSync((Platform.isWindows ? "cls" : "clear"), [], runInShell: true).stdout); 
}

/**
 * Auf Eingabe im Hauptmenu reagieren
 * HINWEIS: Speichern und Laden wurde vorerst deaktiviert. Speichern funktioniert, Laden - eigentlich - auch, es gibt aber ein
 * Problem mit den Datentypen (List<Map<String, dynamic>> != Map<String, dynamic> beim Laden mit jsondecode...)
 */
bool getChoices() {
  bool shouldEnd = false;
  
  String option = getInput("Ihre Auswahl:");
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
          stdout.writeln("Sie haben Änderungen vorgenommen, die noch nicht gespeichert wurden!");
          if(getInput("Wollen Sie das Programm trotzdem verlassen (j/n)") != "j") { shouldEnd = false; }
        }
      default:
        invalidInput();
    } else {
      invalidInput();      
    }
  return shouldEnd;
}

void invalidInput() {
  stdout.writeln("\nUngültige Eingabe!");
  getInput("Return um zum Hauptmenue zurückzukehren...");
}

/**
 * Funktion zum Anlegen eines neuen Eintrags
 * Neue Einträge werden am Ende der Liste angehängt und dann wieder alle Einträge neu nach Datum sortiert.
 * Zudem besteht die Möglichkeit, mehrere Einträge nacheinander vorzunehmen.
 */
bool addEntry() {
  Map<String, dynamic> newEntry = {"Datum":null, "Text":null, "Soll":null, "Haben":null};

  stdout.writeln("\nBitte geben Sie nun die Daten des Vorgangs nacheinander ein.\nNach Eingabe des Betrags können Sie wählen, "+
                "ob es sich um eine Einnahme oder eine Ausgabe handelt.\nEine leere Eingabe des Datums bricht den Erfassungsvorgang ab.");
  
  bool added = true;
  try {
    List<String> tmj = [];
    while(DateTime.tryParse(tmj.reversed.join("-"))==null) {
      String datum = getInput("Datum (dd.mm.jjjj)");
      // Abbruch bei ungewollter Eingabe ermöglichen
      if(datum=="") {     
        getInput("Return um zum Hauptmenue zurückzukehren...");
        return false;
      }

      tmj = datum.split(".");
      // Datumwerte (Tag, Monat, Jahr) getrennt mit führenden Nullen und, falls das Jahr nur zweistellig ist, auf 1951-2050 umstellen
      tmj = [tmj[0].padLeft(2,"0"), tmj[1].padLeft(2,"0"), (int.parse(tmj[2])>100?tmj[2]:int.parse(tmj[2])>50?int.parse(tmj[2])+1900:int.parse(tmj[2])+2000).toString()];
    }
    newEntry["Datum"] = tmj.join("."); // vorher Datetime, jetzt als String, da Datetime nicht als json-Datentyp akzeptiert wurde !!!
    newEntry["Text"] = getInput("Beschreibung des Vorgangs");
    
    double? betrag = null;
    while(betrag == null) {
      String input = getInput("Betrag");
      if(input == "") {
        return false;
      }
      
      betrag = double.tryParse(input.replaceAll(",", "."));
      if(betrag == null || betrag < 0) {
        stdout.writeln("Betrag ungültig oder negativ. Bitte erneut eingeben oder Return zum Abbruch!");
      }
    }
    
    String art = "";
    art = getInput("Einnahme oder Ausgabe (e/a)").toLowerCase();
    while(art != "e" && art != "a") {
      art = getInput("Einnahme oder Ausgabe (e/a)").toLowerCase();
    }
    newEntry["Soll"] = art == "e" ? betrag : 0.0;
    newEntry["Haben"] = art == "a" ? betrag : 0.0;

    if(!newEntry.containsValue(null)) {
      Entries.add(newEntry);
      Entries.sort((e1, f1) { var e2 = toDateTime(e1["Datum"]); var f2 = toDateTime(f1["Datum"]); return e2.compareTo(f2); }); 
      stdout.writeln("Es wurde dieser Eintrag hinzugefügt: $newEntry");

      notSaved = true;
    } else throw ArgumentError("Mindestens eine Eingabe war nicht korrekt. Bitte wiederholen!");
  } 
  catch(e) {
    stdout.writeln("Fehler: $e, Eintrag konnte nicht hinzugefügt werden! Bitte wiederholen...");
    added = false;
  }

  if(getInput("Wollen Sie gleich einen weiteren Eintrag vornehmen (j/n)")!="j") {
    getInput("Return um zum Hauptmenue zurückzukehren...");
    return added;
  }

  return addEntry();
}

/**
 * Umwandlung des Datums von "dd.mm.jjjj" zu Datetime (Format "yyyy-mm-dd")
 */
DateTime toDateTime(String datum) {
  return DateTime.parse(datum.split(".").reversed.join("-")); // entspr. (datum.substring(6,10)+"-"+datum.substring(3,5)+"-"+datum.substring(0,2));
}

/**
 * Sortieren aller Einträge nach Datum
 */
void sortEntries() {
  Entries.sort((e1, f1) { var e2 = toDateTime(e1["Datum"]); var f2 = toDateTime(f1["Datum"]); return e2.compareTo(f2); }); 
  getInput("Return um zum Hauptmenue zurückzukehren...");
}

/**
 * Löschen eines Eintrags über seine Index-Nummer
 */
bool deleteEntry() {
  if(Entries.length>0) {
    stdout.writeln("Zum Löschen eines Eintrages wird die Nummer des Eintrags benötigt.");
    if(getInput("Soll die Liste einmal zur Ermittlung der Nummer ausgegeben werden (j/n)").toLowerCase()=="j") {
      listEntries(withoutBackToMenu: true);
    }
    String input = getInput("Bitte die Nummer des zu löschenden Eintrags eingeben (nur Return = Abbruch)");
    if(input != "") {
      int nr = int.tryParse(input) ?? -1;
      if(nr>=0 && nr<Entries.length) {
        stdout.writeln("Dieser Eintrag wurde zu Ihrer Eingabe gefunden:\n" + getEntry(Entries[nr]));
        if(getInput("Soll dieser Eintrag gelöscht werden")=="j") {
          Entries.remove(Entries[nr]);
          stdout.writeln("Der gewünschte Eintrag wurde entfernt.");
          notSaved = true;
        }
      }
    }
  } else { 
    stdout.writeln("Es gibt keine Einträge, also kann auch kein Eintrag gelöscht werden!"); 
  }
  getInput("Return um zum Hauptmenue zurückzukehren...");
  return false;
}

/**
 * paginierte Auflistung aller eingegebenen Einträge (den bekannten Möglichkeiten des Terminals entsprechend formatiert)
 * und automatischer Saldenbildung nach den (nach Datum sortierten) Einträgen...
 */
void listEntries({bool withoutBackToMenu = false, bool paged = true}) {
  double saldo = 0;

  if(Entries.length>0) {
    // Paginierte Ausgabe (entriesPerPage pro Seite)
    for(int i=0; i<Entries.length;i+=paged ? entriesPerPage : Entries.length) {
      cls();
      stdout.writeln("\nNr    |Datum      |Beschreibung                   |SOLL     €|HABEN    €|SALDO    € S/H");
      if(saldo!=0) stdout.writeln("      |           |Übertag                        |"+
                                  "${saldo>=0?saldo.abs().toStringAsFixed(2).padLeft(9):"         "} |"+
                                  "${saldo<0?saldo.abs().toStringAsFixed(2).padLeft(9):"         "} |"+
                                  "${saldo.abs().toStringAsFixed(2).padLeft(9)} ${saldo<0?"  S":"  H"}");
      for(int j=i; j<Entries.length && (paged ? (j<i+entriesPerPage) : true); j++) {
        saldo += (Entries[j]["Soll"] ?? 0) - (Entries[j]["Haben"] ?? 0);
        stdout.writeln(getEntry(Entries[j])+"|${saldo.abs().toStringAsFixed(2).padLeft(9)} ${saldo<0?"  S":"  H"}");
      }
      stdout.writeln("                                                  |----------|----------|\n"+
                     "                                                  |"+
                     (saldo<0?saldo.abs().toStringAsFixed(2).padLeft(9):"         ")+" |"+
                     (saldo>=0?saldo.abs().toStringAsFixed(2).padLeft(9):"         ")+" |");

      if(paged && i+entriesPerPage<Entries.length) { 
        getInput("Return zum Fortsetzen..."); 
      }
    }
    stdout.writeln("\nIhr Konto steht mit ${saldo.abs().toStringAsFixed(2)} € im ${saldo<0?"SOLL":"HABEN"}.");
  } else { 
    stdout.writeln("Keine Einträge vorhanden!");
  }
  if(!withoutBackToMenu) {
    getInput("Return, um zum Hauptmenue zurückzukehren...");
  }
}

/**
 * Anzeige eines Eintrags (ohne Saldo!)
 */
String getEntry(Map entry) {
  return "${Entries.indexOf(entry).toString().padLeft(3)})  |${entry["Datum"]} "+
         "|${(entry["Text"] as String).padRight(30)} "+
         "|${(entry["Soll"] as double) == 0?"         ":(entry["Soll"] as double).toStringAsFixed(2).padLeft(9)} "+
         "|${(entry["Haben"] as double) == 0?"         ":(entry["Haben"] as double).toStringAsFixed(2).padLeft(9)} ";
         // "|${saldo.abs().toStringAsFixed(2).padLeft(9)} ${saldo<0?"  S":"  H"}";
    
}

/**
 * Möglichkeit, die Anzahl der anzuzeigenen Einträge bei der Auflistung pro "Seite" zu verändern
 */
void changePagesize() {
  stdout.writeln("\nBitte geben Sie hier an, wieviele Einträge pro Seite beim Auflisten angezeigt werden sollen! (return = keine Änderung)");
  String input = getInput("Wieviele Einträge sollen pro Seite aufgelistet werden (aktuell: $entriesPerPage)");
  if(input!="") {
    entriesPerPage = int.tryParse(input) ?? entriesPerPage;
  }
  stdout.writeln("Ab jetzt werden beim Auflisten von Einträgen pro Durchlauf (max.) $entriesPerPage Einträge angezeigt.");
  getInput("Return, um zum Hauptmenue zurückzukehren...");
}

/**
 * Textsuche in der Eintragsbezeichnung der Einträge
 */
void searchEntry() {
  stdout.writeln("Aktuell steht nur die Textsuche für die Vorgangsbeschreibung zur Verfügung!");
  String input = getInput("Nach welchem Text soll gesucht werden (unabhängig von Groß- und Kleinschreibung)");
  Entries.where((element) => element["Text"].toString().toLowerCase().contains(input.toLowerCase())).forEach((element) => stdout.writeln(getEntry(element)));
  getInput("Return, um zum Hauptmenue zurückzukehren...");
}

/**
 * Speicherung der Daten im json-Format (Funktioniert auch...)
 */
bool saveAll() {
  String fn = getInput("Bitte Dateinamen angeben (.json wird - falls nicht angegeben - automatisch angehängt)");
  fn = !fn.endsWith(".json") ? fn + ".json" : fn;

  File file = File("./" + fn);
  
  file.writeAsStringSync(jsonEncode(Entries), flush: true);
  getInput("Speicherung erfolgreich!\nReturn, um zum Hauptmenue zurückzukehren...");

  notSaved = false;
  return true;
}

/**
 * Laden der Daten aus json-Datei 
 * (Probleme bei Typumwandlung von Map<String, dynamic> zu List<Map<String, dynamic>>, daher werden die Daten
 * als List<dynamic> geladen und die Einträge von dort in die List<Map<>> kopiert)
 */
bool load({String? filename = null, bool withoutBackToMenu = false}) {
  filename = filename ?? getInput("Bitte Dateinamen angeben (.json wird - falls nicht angegeben - automatisch angehängt)");
  filename = !filename.endsWith(".json") ? filename + ".json" : filename;

  try {
    File file = File("./" + filename);
    String response = file.readAsStringSync();
    List json = jsonDecode(response);
    // print(json);
    Entries = json;

    // Entries.clear();
    // json.forEach((element) => Entries.add(element)); // ...das muss doch auch anders gehen???
  } 
  catch(e) { 
    stdout.writeln("Fehler beim Laden: $e");
    if(!withoutBackToMenu)
      getInput("Return, um zum Hauptmenue zurückzukehren...");
    return false;
  }
  
  stdout.writeln("Daten wurden erfolgreich geladen!");
  if(!withoutBackToMenu)
    getInput("Return, um zum Hauptmenue zurückzukehren...");

  notSaved = false;
  return true;
}

/**
 * Funktion zur Eingabe (mit Beschreibung), Eingabe wird nach der Beschreibung erwartet.
 */
String getInput(String statement) {
  if(stdin.hasTerminal) {
    stdout.write(statement + "? ");
    return stdin.readLineSync() ?? "";
  } else {
    throw("Bitte starten Sie das Programm im Terminal um Eingaben zu ermöglichen");
  }
}

void infos({bool withoutBackToMenu = false}) {
  List<String> _infos = ["Willkommen zu 💰 Haushalt V2💰\n","Dieses kleine Programm entstand als Projektaufgabe i.R. meiner Weiterbildung zum App-Entwickler "+
                         "bei der App Akademie in Berlin in Anlehnung auf ein Programm, das ich schon Ende der 80er/Anfang der 90er auf einem Commodore "+
                         "C64 in Microsoft BASIC V2 (in Ermangelung eines PC's) entwickelt hatte, um damit meine Buchhaltung (Einnahmeüberschussrechnung) "+
                         "für meinen damals selbständigen Gebrauchtwagenhandel zu betreiben.","Im Gegensatz zu dieser moderneren Variante musste ich damals "+
                         "allerdings noch sowohl das Programm als auch die Daten (sequenziell) auf einem Magnetbandlaufwerk ('Musikkassette' !!!) "+
                         "speichern :-).","Eine Möglichkeit des Ausdrucks der Daten (formatiert und paginiert) auf Papier habe ich mir Aufgrund der Tat"+
                         "sache, dass das ursprüngliche Programm eigentlich schon am ersten Tag nach Erteilung der Aufgabe grundsätzlich schon fertig war "+
                         "und diese Version V2 eigentlich nur enstand, da ich einfach Lust dazu hatte, zwischendurch andere Verbesserungen und Erweiterungen zu "+
                         "programmieren, nicht implementiert. Allerdings bräuchte dazu nur die Ausgabe statt stdout auf einen Druckerkanal oder in eine "+
                         "Datei, die dann druckbar wäre, umgelenkt werden...\n","So, was kann das Programm? - Ganz einfach: man kann in (aktuell nur) einem "+
                         "Konto Ein- und Ausgaben jeglicher Art mit Datum und einer kurzen Beschreibung erfassen. Die eingegebenen Daten werden nach "+
                         "Datum sortiert in einer Liste gespeichert und können so in kaufmännischer Weise als Liste mit dem gebildeten Saldo und seitenweise "+
                         "gebildetem Übertrag (SOLL nach HABEN bzw. umgekehrt) ausgegeben werden. Zudem besteht die Möglichkeit, Datensätze zu suchen "+
                         "oder Datensätze nach deren Nummer zu löschen. Alle angelegten Datensätze können (als json-Datei) gespeichert und bei Programm"+
                         "start (über Terminalparameter) oder später im Programm selbst geladen werden.","Im Grunde sollte alles weitere intuitiv über das "+
                         "Menü herauszufinden und entsprechend bedienbar sein :-)\n","😁 Viel Spass beim Benutzen wünscht Euch euer\n\n --==> MICROWALKER <==--\n\n"];
  cls();
  stdout.writeAll(_infos,"\n");
  if(!withoutBackToMenu) {
    getInput("Return um zum Hauptmenue zurückzukehren");
  }
}