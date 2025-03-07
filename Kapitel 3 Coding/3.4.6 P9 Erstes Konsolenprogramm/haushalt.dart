import 'dart:io';
import 'dart:convert';

bool notSaved = false;
List<Map<String, dynamic>> Entries = [];
// Map<String, Map<String, dynamic>> Entries = {"Entries":{}}; // Test als mögliche Lösung für korrektes Json-Laden
int entriesPerPage = 5;

/**
 * Haushaltbuchführung als Konsolenprogramm
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
  List<String> menuOptions = [" 1 - Neuer Eintrag"," 2 - Eintrag löschen","\n 3 - Alle Einträge auflisten"," 4 - Anzahl Elemente pro Seite ändern (für Option 3)",
                              "\n 5 - Suchen"," D - Alle Einträge nach Datum sortieren","\n S - als Datei Speichern"," L - Datei Laden","\n E - Ende","\n"];

  print(Process.runSync("clear", [], runInShell: true).stdout); // Guter Tipp von https://github.com/dart-lang/sdk/issues/48953 !!!
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
      stdout.writeln("\nUngültige Eingabe!");
      getInput("Return um zum Hauptmenue zurückzukehren...");
  }
  return shouldEnd;
}

/**
 * Funktion zum Anlegen eines neuen Eintrags
 * Neue Einträge werden am Ende der Liste angehängt und dann wieder alle Einträge neu nach Datum sortiert.
 */
bool addEntry() {
  Map<String, dynamic> newEntry = {"Datum":null, "Text":null, "Betrag":null};

  stdout.writeln("\nBitte geben Sie nun die Daten des Vorgangs nacheinander ein. Ausgaben stellen Sie bitte ein Minus voran!");
  
  bool added = true;
  try {
    String datum = getInput("Datum (dd.mm.jjjj):");
    newEntry["Datum"] = datum; // vorher Datetime, jetzt als String, da Datetime nicht als json-Datentyp akzeptiert wurde !!!
    newEntry["Text"] = getInput("Beschreibung des Vorgangs");
    newEntry["Betrag"] = double.tryParse(getInput("Betrag"));

    Entries.add(newEntry);
    Entries.sort((e1, f1) { var e2 = toDateTime(e1["Datum"]); var f2 = toDateTime(f1["Datum"]); return e2.compareTo(f2); }); 
    stdout.writeln("Es wurde dieser Eintrag hinzugefügt: $newEntry");

    notSaved = true;
  } 
  catch(e) {
    stdout.writeln("Fehler: $e, Eintrag konnte nicht hinzugefügt werden!");
    added = false;
  }

  getInput("Return um zum Hauptmenue zurückzukehren...");
  return added;
}

/**
 * Umwandlung des Datums von "dd.mm.jjjj" zu Datetime (Format "yyyy-mm-dd")
 */
DateTime toDateTime(String datum) {
  return DateTime.parse(datum.substring(6,10)+"-"+datum.substring(3,5)+"-"+datum.substring(0,2));
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
  int maxText = 0;
  Entries.forEach((e) { maxText = e["text"].toString().length > maxText ? e["text"].toString().length : maxText; });
  stdout.writeln("\nNr  |Datum      |Beschreibung                   |Betrag   |Saldo");
  if(Entries.length>0) {
    for(int i=0; i<Entries.length;i+=entriesPerPage) {
      for(int j=i; j<i+entriesPerPage && j<Entries.length; j++) {
        saldo += Entries[j]["Betrag"] ?? 0;
        stdout.writeln("$j)  |${Entries[j]["Datum"]} |${(Entries[j]["Text"] as String).padRight(30)} |${(Entries[j]["Betrag"] as double).toStringAsFixed(2).padLeft(8)} |${saldo.toStringAsFixed(2).padLeft(8)}");
      }
      if(i+entriesPerPage<Entries.length) { 
        getInput("Return zum Fortsetzen..."); 
      }
    }
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
  
  file.writeAsStringSync(jsonEncode(Entries));
  getInput("Return, um zum Hauptmenue zurückzukehren...");

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
