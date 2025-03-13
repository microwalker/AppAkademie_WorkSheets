abstract class BonusFunctions {
  /**
   * Konvertiert Minuten in Stunden und Minuten
   */
  static void convertMinutesToTime(int minutes) {
    print("[$minutes Minuten sind:] ${minutes ~/ 60} Stunden und ${minutes % 60} Minuten"); }

  /**
   * Gibt Noten innerhalb einer Liste nacheinander, durch Komma getrennt, aus
   */
  static void printGrades(List<int> grades) {
    // Gibt alle Noten nacheinander aus
    // z.B.: Note 1: 2, Note 2: 1, Note 3: 3
    String noten = "";
    for(int i = 0; i < grades.length; i++) noten+="Note ${i+1}: ${grades[i]}${i<grades.length-1?", ":""}";
    print(noten);
  }

  /**
   * Berechnet den Durchschnitt aller Noten innerhalb einer Liste und gibt diesen aus
   */
  static void calculateAndPrintAverage(List<int> grades) {
    // Berechnet den Durchschnitt und gibt aus:
    // "Der Durchschnitt ist: 2.0"
    print("Der Durchschnitt ist: ${grades.fold(0, (p, e) => p + e) / grades.length}");
  }

  /**
   * Sammelfunktion: Führt die Analyse von Noten innerhalb einer Liste aus
   */
  static void analyzeGrades(List<int> grades) {
    printGrades(grades);
    calculateAndPrintAverage(grades);
  }

  /**
   * Ermittelt die grösste und die kleinste Zahl innerhalb einer Liste und gibt das Ergebnis mit der Angabe
   * der ersten gefundenen Positionen der entsprechenden Zahlen in der Liste aus
   */
  static void findAndPrintExtreme(List<int> numbers) {
    // Findet und gibt kleinste und größte Zahl aus
    // Zeigt auch deren Position in der Liste
    int min = numbers.first;
    int max = min;

    for(int number in numbers) {
      min = number < min ? number : min;
      max = number > max ? number : max;
    }

    print("Kleinster Wert (an ${numbers.indexOf(min)+1}. Stelle) ist $min, größter ist $max (an ${numbers.indexOf(max)+1}. Stelle).");
  }

  /**
   * Ermittelt, wieviele gerade/ungerade Zahlen und wieviele positive (inkl. 0) bzw. negative Zahlen in einer 
   * Liste vorhanden sind und gibt das Ergebnis aus
   */
  static void printNumberTypes(List<int> numbers) {
    // Zählt und gibt aus:
    // - Wie viele gerade/ungerade Zahlen
    // - Wie viele positive/negative Zahlen
    int even = 0;
    int minus = 0;
    numbers.forEach((number) {
      even += number % 2 == 0 ? 1 : 0;
      minus += number < 0 ? 1 : 0;
    });
    print("Die Liste enthält $even gerade und ${numbers.length-even} ungerade Zahlen!\n" +
          "Weiterhin sind $minus Zahlen der Liste negativ, die restlichen ${numbers.length-minus} sind 0 oder positiv!");
  }

  /**
   * Ermittelt, wie oft jede einzelne Zahl innerhalb einer Liste vorkommen und gibt das Ergebnis aus
   */
  static void printDistribution(List<int> numbers) {
    // Gibt eine einfache Häufigkeitsverteilung aus
    // z.B. wie oft kommt jede Zahl vor
    Map<int, int> numAmounts = {};
    for(int number in numbers) {
      if(numAmounts.keys.contains(number)) {
        numAmounts[number] = numAmounts[number]! + 1;
      } else {
        numAmounts[number] = 1;
      }
    };
    for(int key in numAmounts.keys) {
      print("Die Zahl ${key} kam ${numAmounts[key]} mal vor.");
    } 
  }

  // Hauptfunktion:
  /**
   * Sammelfunktion, die alle Funktionen durchführt, um eine Liste von Zahlen zu analysieren
   */
  static void analyzeNumbers(List<int> numbers) {
    // Ruft alle Funktionen der Reihe nach auf
    // Gibt eine übersichtliche Gesamtanalyse
    findAndPrintExtreme(numbers);
    printNumberTypes(numbers);
    printDistribution(numbers);
  }
}
