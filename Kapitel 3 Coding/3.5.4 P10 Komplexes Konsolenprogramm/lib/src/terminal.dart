import 'dart:io';
import 'data.dart';
import 'ansi.dart';

class terminal {
  Stdin termIn = stdin;
  Stdout termOut = stdout;

  terminal();
  terminalFrom(Stdout _out,Stdin _in ) { this.termIn = _in; this.termOut = _out; }

  /**
   * Prüfen, ob das Programm in einem Terminal gestartet wurde
   */
  bool checkTerminal([bool needInput = false]) {
    if(needInput && !termOut.hasTerminal) {
      lineOut("Bitte starten Sie dieses Programm in einem Terminalfenster um Eingaben zu ermöglichen!");
      return false;
    }
    return true;
  }

  String input(String question) {
    out(question+" >");
    return lineIn();
  }
  void out(Object o) => termOut.write(o);
  void lineOut(Object o) => termOut.writeln(o);
  String lineIn() => this.termIn.readLineSync() ?? "";
  String byteIn() => this.termIn.readByteSync().toString();
  cls() => out(Process.runSync((Platform.isWindows ? "cls" : "clear"), [], runInShell: true).stdout); 

  /**
   * Meldung nach üngükltiger Eingabe und warten auf Return
   */
  void invalidInput() {
    lineOut("\nUngültige Eingabe!"); 
    input("Return um zum Hauptmenue zurückzukehren...");
  }

  /**
   * Auf Druck einer beliebigen Taste warten => FUNKTIONIERT (SO) NICHT!!!
   */
  void anyKey() {
    lineOut("Press any Key!");
    byteIn();
  }

  /**
   * Ausgabe des Hauptmenüs auf "gecleantem" Terminal
   */
  void printTerminalMenu() {
    List<String> menuOptions = [
      " 1 - Neue Einträge erfassen",
      "  2 - Einträge suchen",
      "   3 - einen Eintrag löschen",
      "    4 - Alle Einträge ausflisten",
      "     5 - Anzahl Elemente pro Seite ändern (für Ausgabe)",
      "   D - Alle Einträge (erneut) nach Datum sortieren", // Nicht notwendig, da automatisch bei Erfassung von Einträgen
      " S - als Datei Speichern",
      "   L - gespeicherte Datei Laden",
      "     I - Infos zum Programm",
      " E (oder X) - Programm beenden","\n"];

    cls();
    lineOut(setANSI_Colour(ANSI_Colours.MAGENTA) + "💰 Willkommen zur Haushaltsbuchführung!\n\nBitte wählen Sie eine der folgenden Optionen:");
    lineOut(setANSI_Colour(ANSI_Colours.GREEN) + menuOptions.join("\n"));
  }

  /**
   * Druckt eine formatierte Liste der Elemente vom Typ Entry der Klasse Entries aus 
   */
  void printTerminalEntries(Bookings e, [int pageSize = 10, bool paged = true]) {
    // Paginierte Ausgabe (entriesPerPage pro Seite)
    double saldo = 0;
    for(int i=0; i<e.length;i += paged ? pageSize : e.length) {
      cls();
      printBookingsHeader(saldo);

      for(int j=i; j<e.length && (paged ? (j<i+pageSize) : true); j++) {
        saldo += (e.getEntry(j)["Soll"] ?? 0) - (e.getEntry(j)["Haben"] ?? 0);
        printBookingsEntry(e.indexOf(e.getEntry(j)), e.getEntry(j), saldo);
      }

      printBookingsFooter(saldo);

      if(paged && i+pageSize<e.length) { 
        input("Return zum Fortsetzen..."); 
        // anyKey();
      }
    }
    lineOut("\nIhr Konto steht mit ${saldo.abs().toStringAsFixed(2)} € im ${saldo<0?"SOLL":"HABEN"}.");
  }

  void printBookingsHeader([double? saldo = null]) {
    lineOut("\nNr    |Datum      |Beschreibung                   |SOLL     €|HABEN    €|SALDO    € S/H");
    if(saldo != null) 
      lineOut("      |           |Übertag                        |"+
              "${saldo>=0?saldo.abs().toStringAsFixed(2).padLeft(9):"         "} |"+
              "${saldo<0?saldo.abs().toStringAsFixed(2).padLeft(9):"         "} |"+
              "${saldo.abs().toStringAsFixed(2).padLeft(9)} ${saldo<0?"  S":"  H"}");
  }

  /**
  * Anzeige eines Eintrags (ohne Saldo!)
  */
  void printBookingsEntry(int id, Entry entry, [double? saldo = null]) {
    lineOut("${id.toString().padLeft(3)})  |${entry["Datum"]} "+
        "|${(entry["Text"] as String).padRight(30)} "+
        "|${(entry["Soll"] as double) == 0?"         ":(entry["Soll"] as double).toStringAsFixed(2).padLeft(9)} "+
        "|${(entry["Haben"] as double) == 0?"         ":(entry["Haben"] as double).toStringAsFixed(2).padLeft(9)} "+
        "|${saldo != null ? saldo.abs().toStringAsFixed(2).padLeft(9)+" "+(saldo<0?"  S":"  H"):""}");
  }

  /**
   * Ausgabe der Abschlußzeilen jeder Seite
   */
  void printBookingsFooter(double saldo) {
    lineOut("                                                  |----------|----------|\n"+
        "                                                  |"+
        (saldo<0?saldo.abs().toStringAsFixed(2).padLeft(9):"         ")+" |"+
        (saldo>=0?saldo.abs().toStringAsFixed(2).padLeft(9):"         ")+" |");
  }

  void printTerminalInfo() {
    List<String> _infos = ["Willkommen zu 💰 Haushalt V3💰\n","Dieses kleine Programm entstand als Projektaufgabe i.R. meiner Weiterbildung zum App-Entwickler "+
                        "bei der App Akademie in Berlin in Anlehnung auf ein Programm, das ich schon Ende der 80er/Anfang der 90er auf einem Commodore "+
                        "C64 in Microsoft BASIC V2 (in Ermangelung eines PC's) entwickelt hatte, um damit meine Buchhaltung (Einnahmeüberschussrechnung) "+
                        "für meinen damals selbständigen Gebrauchtwagenhandel zu betreiben.","Im Gegensatz zu dieser moderneren Variante musste ich damals "+
                        "allerdings noch sowohl das Programm als auch die Daten (sequenziell) auf einem Magnetbandlaufwerk ('Musikkassette' !!!) "+
                        "speichern :-).","Eine Möglichkeit des Ausdrucks der Daten (formatiert und paginiert) auf Papier habe ich mir Aufgrund der Tat"+
                        "sache, dass das ursprüngliche Programm eigentlich schon am ersten Tag nach Erteilung der Aufgabe grundsätzlich schon fertig war "+
                        "und diese Version V2 eigentlich nur enstand, da ich einfach Lust dazu hatte, zwischendurch andere Verbesserungen und Erweiterungen zu "+
                        "programmieren, nicht implementiert. Allerdings bräuchte dazu nur die Ausgabe statt term auf einen Druckerkanal oder in eine "+
                        "Datei, die dann druckbar wäre, umgelenkt werden...\n","So, was kann das Programm? - Ganz einfach: man kann in (aktuell nur) einem "+
                        "Konto Ein- und Ausgaben jeglicher Art mit Datum und einer kurzen Beschreibung erfassen. Die eingegebenen Daten werden nach "+
                        "Datum sortiert in einer Liste gespeichert und können so in kaufmännischer Weise als Liste mit dem gebildeten Saldo und seitenweise "+
                        "gebildetem Übertrag (SOLL nach HABEN bzw. umgekehrt) ausgegeben werden. Zudem besteht die Möglichkeit, Datensätze zu suchen "+
                        "oder Datensätze nach deren Nummer zu löschen. Alle angelegten Datensätze können (als json-Datei) gespeichert und bei Programm"+
                        "start (über Terminalparameter) oder später im Programm selbst geladen werden.","Im Grunde sollte alles weitere intuitiv über das "+
                        "Menü herauszufinden und entsprechend bedienbar sein :-)\n","😁 Viel Spass beim Benutzen wünscht Euch euer\n\n --==> MICROWALKER <==--\n\n"];
    cls();
    lineOut(_infos.join("\n"));
  }
}