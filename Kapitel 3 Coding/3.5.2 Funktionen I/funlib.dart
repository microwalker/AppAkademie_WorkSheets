import 'dart:math';

void printNumber(int number) => print(number);

void triplePrint(String text) => print(text * 3);

void reverseInitials(String forename, String lastname) {
  print(forename[forename.length-1].toUpperCase() + ". " + lastname[lastname.length-1].toUpperCase() + "."); }

void convertMinutesToTime(int minutes) {
  print("[$minutes Minuten sind:] ${minutes ~/ 60} Stunden und ${minutes % 60} Minuten"); }

void printGrades(List<int> grades) {
  // Gibt alle Noten nacheinander aus
  // z.B.: Note 1: 2, Note 2: 1, Note 3: 3
  String noten = "";
  for(int i = 0; i < grades.length; i++) noten+="Note ${i+1}: ${grades[i]}${i<grades.length-1?", ":""}";
  print(noten);
}

void calculateAndPrintAverage(List<int> grades) {
  // Berechnet den Durchschnitt und gibt aus:
  // "Der Durchschnitt ist: 2.0"
  print("Der Durchschnitt ist: ${grades.fold(0, (p, e) => p + e) / grades.length}");
}

void analyzeGrades(List<int> grades) {
  printGrades(grades);
  calculateAndPrintAverage(grades);
}

void findAndPrintExtreme(List<int> numbers) {
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

void printNumberTypes(List<int> numbers) {
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

void printDistribution(List<int> numbers) {
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
void analyzeNumbers(List<int> numbers) {
  // Ruft alle Funktionen der Reihe nach auf
  // Gibt eine übersichtliche Gesamtanalyse
  findAndPrintExtreme(numbers);
  printNumberTypes(numbers);
  printDistribution(numbers);
}