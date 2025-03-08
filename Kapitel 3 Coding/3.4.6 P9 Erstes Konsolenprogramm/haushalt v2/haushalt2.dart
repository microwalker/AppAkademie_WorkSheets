import 'dart:io';
import 'dart:convert';

bool notSaved = false;
List<Map<String, dynamic>> Entries = [];
// Map<String, Map<String, dynamic>> Entries = {"Entries":{}}; // Test als mögliche Lösung für korrektes Json-Laden
int entriesPerPage = 5;

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
 */

void main(List<String> args) {
   
  // ggf. eingegebene Konsolenargumente prüfen
  if(args.isNotEmpty) {
    checkConsoleArgs(args);
  } 

  // Prüfen, ob das Programm in einem Terminal gestartet wurde
  if(!stdout.hasTerminal) {
    print("Bitte starten Sie die Haushaltsbuchführung in einem Terminalfenster um Eingaben zu ermöglichen!");
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
  stdout.writeln("\nAuf Wiedersehen!");
}

/**
 * prüft auf eventuell vorhandene Eingaben von Parametern beim Programmaufruf
 */
void checkConsoleArgs(List<String> args) {
    switch(args[0]) {
      case "help":
        print("Optionen:\n help - zeigt diese Hilfe an\n load dateiname.dat - lädt eine zuvor gespeicherte Datei mit Buchungsdaten" +
              "\n list dateiname.dat - zeigt alle Buchungen einer gespeicherten Datei an und verläßt dann das Programm\nOhne Param" +
              "eter wird das Programm ohne bzw. zum Erstellen einer neuen Buchungsdatendatei geöffnet!");
      case "load":
        throw(UnimplementedError("Diese Funktion steht noch nicht zur Verfügung"));
      case "list":
        throw(UnimplementedError("Diese Funktion steht noch nicht zur Verfügung"));
      default:
        print("Unbekannte Parameter! Verwenden Sie 'help' um sich die Hilfe anzeigen zu lassen.");
    }
}

/**
 * Ausgabe des Hauptmenüs auf "gecleantem" Terminal
 */
void printMenu() {
  List<String> menuOptions = [" 1 - Neuer Eintrag","  2 - Eintrag löschen","   3 - Alle Einträge auflisten","    4 - Anzahl Elemente pro Seite ändern (für Option 3)",
                              "     5 - Suchen"," D - Alle Einträge nach Datum sortieren","  S - als Datei Speichern","   L - Datei Laden"," E - Ende","\n"];

  // Guter Tipp von https://github.com/dart-lang/sdk/issues/48953 !!!
  print(Process.runSync((Platform.isWindows ? "cls" : "clear"), [], runInShell: true).stdout); 

  stdout.writeln("Willkommen zur Haushaltsbuchführung!\n\nBitte wählen Sie eine der folgenden Optionen:");
  stdout.writeAll(menuOptions, "\n");
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
      case "2": deleteEntry();
      case "3": listEntries();
      case "4": changePagesize();
      case "5": searchEntry();
      case "D": sortEntries();
      case "S": saveAll();
      case "L": load();
      case "E": 
        shouldEnd = true;
        if(notSaved) {
          print("Sie haben noch ungespeicherte Datensätze!");
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
      betrag = double.tryParse(getInput("Betrag").replaceAll(",", "."));
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
    if(input!="") {
      int nr = int.tryParse(input) ?? -1;
      if(nr>=0 && nr<Entries.length) {
        Entries.remove(Entries[nr]);
      }
      stdout.writeln("Der gewünschte Eintrag wurde entfernt.");
    }
    notSaved = true;
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
void listEntries({bool withoutBackToMenu = false}) {
  double saldo = 0;

  if(Entries.length>0) {
    // Paginierte Ausgabe (entriesPerPage pro Seite)
    for(int i=0; i<Entries.length;i+=entriesPerPage) {
      stdout.write(Process.runSync((Platform.isWindows ? "cls" : "clear"), [], runInShell: true).stdout); 
      stdout.writeln("\nNr    |Datum      |Beschreibung                   |SOLL     €|HABEN    €|SALDO    € S/H");
      if(saldo!=0) stdout.writeln("      |           |Übertag                        |"+
                                  "${saldo>=0?saldo.abs().toStringAsFixed(2).padLeft(9):"         "} |"+
                                  "${saldo<0?saldo.abs().toStringAsFixed(2).padLeft(9):"         "} |"+
                                  "${saldo.abs().toStringAsFixed(2).padLeft(9)} ${saldo<0?"  S":"  H"}");
      for(int j=i; j<i+entriesPerPage && j<Entries.length; j++) {
        saldo += (Entries[j]["Soll"] ?? 0) - (Entries[j]["Haben"] ?? 0);
        stdout.writeln("${j.toString().padLeft(3)})  |${Entries[j]["Datum"]} "+
                       "|${(Entries[j]["Text"] as String).padRight(30)} "+
                       "|${(Entries[j]["Soll"] as double) == 0?"         ":(Entries[j]["Soll"] as double).toStringAsFixed(2).padLeft(9)} "+
                       "|${(Entries[j]["Haben"] as double) == 0?"         ":(Entries[j]["Haben"] as double).toStringAsFixed(2).padLeft(9)} "+
                       "|${saldo.abs().toStringAsFixed(2).padLeft(9)} ${saldo<0?"  S":"  H"}");
      }
      stdout.writeln("                                                  |----------|----------|\n"+
                     "                                                  |"+
                     (saldo<0?saldo.abs().toStringAsFixed(2).padLeft(9):"         ")+" |"+
                     (saldo>=0?saldo.abs().toStringAsFixed(2).padLeft(9):"         ")+" |");

      if(i+entriesPerPage<Entries.length) { 
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
  String input = getInput("Nach welchem Text soll gesucht werden?");
  Entries.where((element) => element["Text"].contains(input)).forEach((element) => print(element));
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
bool load({String? filename = null}) {
  String fn = getInput("Bitte Dateinamen angeben (.json wird - falls nicht angegeben - automatisch angehängt)");
  fn = !fn.endsWith(".json") ? fn + ".json" : fn;

  try {
    File file = File("./" + fn);
    String response = file.readAsStringSync();
    List json = jsonDecode(response);
    // print(json);
    Entries.clear();
    json.forEach((element) => Entries.add(element)); // ...das muss doch auch anders gehen???
  } 
  catch(e) { 
    print("Fehler beim Laden: $e");
    getInput("Return, um zum Hauptmenue zurückzukehren...");
    return false;
  }
  
  getInput("Daten wurden erfolgreich geladen!\nReturn, um zum Hauptmenue zurückzukehren...");
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
