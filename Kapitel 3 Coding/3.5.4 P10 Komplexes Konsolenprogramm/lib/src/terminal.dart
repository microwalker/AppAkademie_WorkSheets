import 'dart:io';
import 'data.dart';
import 'ansi.dart';

/**
 * Terminal-Klasse für "Haushalt V3.1"
 * mit integrierter ANSI-Library (© 2025 Microwalker)!
 * 
 * © 2025 Microwalker
 * ==================
 * (später ggf. Umleitung auf neues externes Terminal angedacht...)
 */
class Terminal {
  Stdin termIn = stdin;
  Stdout termOut = stdout;
  String _stdColor = setANSI_Colour(ANSI_Colours.WHITE);

  final String red = setANSI_Colour(ANSI_Colours.RED);
  final String cyan = setANSI_Colour(ANSI_Colours.CYAN);
  final String green = setANSI_Colour(ANSI_Colours.GREEN);
  final String yellow = setANSI_Colour(ANSI_Colours.YELLOW);
  final String blink = setANSI_TextMode(ANSI_TextModes.BLINKING);
  final String white = setANSI_Colour(ANSI_Colours.WHITE);
  final String reset = resetAllANSI_TextModes();

  set stdColor(ANSI_Colours color) { _stdColor = setANSI_Colour(color); }

  Terminal();
  from(Stdout _out,Stdin _in ) { this.termIn = _in; this.termOut = _out; }

  /**
   * Prüfen, ob das Programm in einem Terminal gestartet wurde
   */
  bool checkTerminal([bool needInput = false]) {
    if(needInput && !termOut.hasTerminal) {
      lineOut("${this.red}Bitte starten Sie dieses Programm in einem Terminalfenster um Eingaben zu ermöglichen!");
      return false;
    }
    return true;
  }

  String input(String question) {
    out(yellow+question+" >"+white);
    return lineIn();
  }
  void out(Object o) => termOut.write("${_stdColor}$o");
  void lineOut(Object o) => termOut.writeln("${_stdColor}$o");
  String lineIn() => this.termIn.readLineSync() ?? "";
  String byteIn() => this.termIn.readByteSync().toString();
  cls() => out(Process.runSync((Platform.isWindows ? "cls" : "clear"), [], runInShell: true).stdout); 

  /**
   * Meldung nach üngültiger Eingabe und warten auf Return
   */
  void invalidInput() {
    lineOut("\n${this.red+this.blink}Ungültige Eingabe!${reset}"); 
    input("\nReturn um zum Hauptmenue zurückzukehren...");
  }

  /**
   * Auf Druck einer beliebigen Taste warten => FUNKTIONIERT (SO) NICHT!!!
   */
  void anyKey() {
    lineOut("${yellow+blink}\nPress any Key!${reset}");
    byteIn();
  }

  /**
   * Ausgabe des Hauptmenüs auf "gecleantem" Terminal
   */
  void printTerminalMenu() {
    List<String> menuOptions = [
      " ${this.yellow}[1]${this.cyan} - Neue Einträge erfassen",
      "  ${this.yellow}[2]${this.cyan} - Einträge suchen",
      "   ${this.yellow}[3]${this.cyan} - einen Eintrag löschen",
      " ${this.yellow}[4]${this.cyan} - Alle Einträge (seitenweise) ausflisten",
      "  ${this.yellow}[5]${this.cyan} - Anzahl Elemente pro Seite ändern (für Ausgabe)",
      "   ${this.yellow}[P]${this.cyan} - Alle Einträge (durchgehend) auflisten",
      "    ${this.yellow}[D]${this.cyan} - Alle Einträge (erneut) nach Datum sortieren", // Nicht notwendig, da automatisch bei Erfassung von Einträgen
      " ${this.yellow}[S]${this.cyan} - als Datei Speichern",
      "  ${this.yellow}[L]${this.cyan} - gespeicherte Datei Laden",
      "   ${this.yellow}[I]${this.cyan} - Infos zum Programm",
      " ${this.yellow}[E]${this.cyan} (oder ${this.yellow}[X]${this.cyan}) - Programm beenden","\n"];

    cls();
    lineOut(setANSI_Colour(ANSI_Colours.BLUE) + "${green}💰 Willkommen zur Haushaltsbuchführung V3.1!\n\n");
    lineOut(setANSI_Colour(ANSI_Colours.YELLOW) + "${cyan}Bitte wählen Sie eine der folgenden Optionen:\n");
    lineOut(menuOptions.join("\n"));
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
        input("\nReturn zum Fortsetzen..."); 
        // anyKey();
      }
    }
    lineOut("\n${cyan}Ihr Konto steht mit ${saldo<0?red:green}${saldo.abs().toStringAsFixed(2)} € im ${saldo<0?"${red}SOLL":"${green}HABEN"}${cyan}.");
  }

  void printBookingsHeader([double? saldo = null]) {
    lineOut("\n${yellow}Nr    |Datum      |Beschreibung                   |SOLL     €|HABEN    €|SALDO    € S/H");
    if(saldo != null) 
      lineOut("${yellow}      |           |${white}Übertag                        ${yellow}|"+
              "${green}${saldo>=0?saldo.abs().toStringAsFixed(2).padLeft(9):"         "} ${yellow}|"+
              "${red}${saldo<0?saldo.abs().toStringAsFixed(2).padLeft(9):"         "} ${yellow}|"+
              "${saldo<0?red:green}${saldo.abs().toStringAsFixed(2).padLeft(9)} ${saldo<0?"  ${red}S":"  ${green}H"}");
  }

  /**
  * Anzeige eines Eintrags (ohne Saldo!)
  */
  void printBookingsEntry(int id, Entry entry, [double? saldo = null]) {
    lineOut("${yellow}${id.toString().padLeft(3)})  ${yellow}|${white}${entry["Datum"]} "+
        "${yellow}|${white}${(entry["Text"] as String).padRight(30)} "+
        "${yellow}|${white}${(entry["Soll"] as double) == 0?"         ":(entry["Soll"] as double).toStringAsFixed(2).padLeft(9)} "+
        "${yellow}|${white}${(entry["Haben"] as double) == 0?"         ":(entry["Haben"] as double).toStringAsFixed(2).padLeft(9)} "+
        "${yellow}|${saldo != null ? (saldo<0?red:green) + saldo.abs().toStringAsFixed(2).padLeft(9)+" "+(saldo<0?"  ${red}S":"  ${green}H"):""}");
  }

  /**
   * Ausgabe der Abschlußzeilen jeder Seite
   */
  void printBookingsFooter(double saldo) {
    lineOut("${yellow}                                                  |----------|----------|\n"+
        "                                                  |"+
        (saldo<0?red + saldo.abs().toStringAsFixed(2).padLeft(9):"         ")+" ${yellow}|"+
        (saldo>=0?green + saldo.abs().toStringAsFixed(2).padLeft(9):"         ")+" ${yellow}|");
  }

  void printTerminalInfo() {
    List<String> _infos = ["${this.yellow}Willkommen zu 💰 Haushalt V3.1\n","${cyan}Dieses kleine Programm entstand als Projektaufgabe i.R. meiner Weiterbildung zum App-Entwickler "+
                        "bei der App Akademie in Berlin in Anlehnung auf ein Programm, das ich schon Ende der 80er/Anfang der 90er auf einem ${white}Commodore "+
                        "C64 in Microsoft BASIC V2${cyan} (in Ermangelung eines PC's) entwickelt hatte, um damit meine Buchhaltung (Einnahmeüberschussrechnung) "+
                        "für meinen damals selbständigen Gebrauchtwagenhandel zu betreiben.","Im Gegensatz zu dieser moderneren Variante musste ich damals "+
                        "allerdings noch sowohl das Programm als auch die Daten (sequenziell) auf einem Magnetbandlaufwerk (${red}'Musikkassette'${cyan} !!!) "+
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
                        "Menü herauszufinden und entsprechend bedienbar sein :-)\n","😁 ${green}Viel Spass beim Benutzen${cyan} wünscht Euch euer\n\n"+
                        "${green+blink} --==> MICROWALKER <==-- ${reset}\n\n"];
    cls();
    lineOut(_infos.join("\n"));
  }
}