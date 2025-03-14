import 'lib/functions.dart';

void main(List<String> args) {

  // Aufgabe 1
  print("\nAufgabe 1:");
  print("- Größere Nummer ermitteln");
  print(bonus.greaterNum(2,4));
  print(bonus.greaterNum(8,2));
  print(bonus.greaterNum(7,5));

  // Aufgabe 2
  print("\nAufgabe 2:");
  print("- Auf gerade Nummer prüfen");
  print(bonus.even(3));
  print(bonus.even(8));
  print(bonus.even(11));

  // Aufgabe 3
  print("\nAufgabe 3:");
  print("- Summe aus Liste von Zahlen bilden");
  print(bonus.sumFromList([4,9,3,6,1,8]));
  print(bonus.sumFromList([11,18,55,4,21]));
  print(bonus.sumFromList([5,10]));

  // Aufgabe 4
  print("\nAufgabe 4:");
  print("- Durchschnitt aus Liste von Zahlen bilden");
  print(bonus.avgFromList([4,9,3,6,1,8]));
  print(bonus.avgFromList([11,18,55,4,21]));
  print(bonus.avgFromList([5,10]));

  // Aufgabe 5
  print("\nAufgabe 5:");
  print("- Anzahl eines Zeichens innerhalb eines Wortes ermitteln");
  print(bonus.countChars("Kartoffel", "F"));
  print(bonus.countChars("Flötotto", "t"));
  print(bonus.countChars("Repository", "I"));

  // Aufgabe 6
  print("\nAufgabe 6:");
  print("- Vorhandensein eines Zeichens innerhalb eines Wortes ermitteln");
  print(bonus.contains("Kartoffel", "i"));
  print(bonus.contains("Flötotto", "c"));
  print(bonus.contains("Repository", "p"));

  // Aufgabe 7
  print("\nAufgabe 7:");
  print("- Wertigkeit einer Zahl ermitteln (Rückgabe -1/0/1)");
  print(bonus.valence(0));
  print(bonus.valence(15));
  print(bonus.valence(-8));

  // Aufgabe 8
  print("\nAufgabe 8:");
  print("- Alle Zeichen eines Strings in einer Liste anzeigen");
  print(bonus.charsOf("Das Wandern ist des Müllers Lust!"));
  print(bonus.charsOf("Nur der frühe Vogel fängt den Wurm!"));
  print(bonus.charsOf("Wann ist mal endlich wieder Sommer?"));

  // Aufgabe 9
  print("\nAufgabe 9:");
  print("- Anzahl von Zeichen von Strings in einer Liste ermitteln");
  print(bonus.getCharCount(["Das Wandern ist des Müllers Lust!","Fischers Fritz fischt frische Fische."]));
  print(bonus.getCharCount(["Nur der frühe Vogel fängt den Wurm!","Na, wie viele Zeichen hat die Zeichenkette?)"]));
  print(bonus.getCharCount(["Wann ist mal endlich wieder Sommer?","War's das?"]));

  // Aufgabe 10
  print("\nAufgabe 10:");
  print("- Elemente einer Liste miteinander multiplizieren");
  print(bonus.productOfList([4,5,10]));
  print(bonus.productOfList([2,21,5]));
  print(bonus.productOfList([17,3,9]));

  // Aufgabe 11
  print("\nAufgabe 11:");
  print("- Wert negieren");
  print(bonus.neg(12));
  print(bonus.neg(-21));
  print(bonus.neg(0));

  // Aufgabe 12
  print("\nAufgabe 12:");
  print("- Die kleinste Zahl innerhalb einer Liste ermitteln");
  print(bonus.smallest([4,5,10]));
  print(bonus.smallest([2,21,5]));
  print(bonus.smallest([17,3,9]));

  // Aufgabe 13
  print("\nAufgabe 13:");
  print("- Anzahl der Zeichen für jedes Wort eines Strings innerhalb einer Liste zählen");
  print(bonus.countWordChars(["Komm Opa, Essen!","Was gibt es denn?","Currywurst und Pommes!"]));
  print(bonus.countWordChars(["Komm, Opa essen!","Ich mag Opa nicht!","Opa ist so zäh!!!"]));
  print(bonus.countWordChars(["Ein Satz","Einsatz"]));

  // Aufgabe 14
  print("\nAufgabe 14:");
  print("- Temperatur von Fahrenheit in Celsius oder andersherum umrechnen");
  print(bonus.changeTemperature(22));
  print(bonus.changeTemperature(73, true));
  print(bonus.changeTemperature(-7, false));

  // Aufgabe 15
  print("\nAufgabe 15:");
  print("- Strings innerhalb einer Liste zusammenfassen");
  print(bonus.foldStrings(["Komm Opa, Essen!","Was gibt es denn?","Currywurst und Pommes!"]));
  print(bonus.foldStrings(["Komm, Opa essen!","Ich mag Opa nicht!","Opa ist so zäh!!!"]));
  print(bonus.foldStrings(["Ein Satz","Einsatz"]));

  // Aufgabe 16
  print("\nAufgabe 16:");
  print("- Ermitteln, ob eine Zahl eine Primzahl ist");
  print(bonus.isPrime(27));
  print(bonus.isPrime(7));
  print(bonus.isPrime(841));

  // Aufgabe 17
  print("\nAufgabe 17:");
  print("- Zahlenwerte umkehren");
  print(bonus.reverseNumber(1234));
  print(bonus.reverseNumber(876543));
  print(bonus.reverseNumber(24));

  // Aufgabe 18
  print("\nAufgabe 18:");
  print("- Sekunden in Stunden:Minuten:Sekunden umrechnen");
  print(bonus.toHMS(43532538));
  print(bonus.toHMS(4586));
  print(bonus.toHMS(945623));
  
  // Aufgabe 19
  print("\nAufgabe 19:");
  print("- Prüfen, ob zwei Worte ein Anagramm sind");
  print(bonus.isAnagram("Tor", "Rot"));
  print(bonus.isAnagram("Ferien", "Reifen"));
  print(bonus.isAnagram("Tastatur", "Maus"));

  print("- Prüfen, ob zwei Worte ein Anagramm sind (mit isAnagram2)");
  print(bonus.isAnagramLINQ("Tor", "Rot"));
  print(bonus.isAnagramLINQ("Ferien", "Reifen"));
  print(bonus.isAnagramLINQ("Tastatur", "Maus"));

  // Aufgabe 20
  print("\nAufgabe 20:");
  print("- Werte ohne den Einsatz des Operators '*' miteinander multiplizieren");
  print(bonus.multiplicateWithoutMultiplicationOperator(10, 88));
  print(bonus.multiplicateWithoutMultiplicationOperator(5, 25));
  print(bonus.multiplicateWithoutMultiplicationOperator(3, 3));

  // Aufgabe 21
  print("\nAufgabe 21:");
  print("- Worte eines Strings, durch Leerzeichen getrennt, voneinander trennen, ohne Funktionen dabei zu benutzen");
  print(bonus.getWords("Rosen sind rot Veilchen sind blau"));
  print(bonus.getWords("Ist das nicht eine ganz tolle Funktion"));
  print(bonus.getWords("Supercalifragilisticexpialigetisch"));

  // Aufgabe 22
  print("\nAufgabe 22:");
  print("- Ermitteln, ob es sich bei einem Wort um ein Palindrom handelt");
  print(bonus.isPalindrom("Lagerregal"));
  print(bonus.isPalindrom("Grützwurst"));
  print(bonus.isPalindrom("Rentner"));

  //Aufgabe 23
  print("\nAufgabe 23:");
  print("- Inhalt eines Strings auf korrekte Klammernsetzung prüfen");
  print(bonus.checkBrackets("(22/(7+4)*(6-2)*5)"));
  print(bonus.checkBrackets("((31+1)*((4*(19-9)*(5/(11+4))/2)%5)+10"));
  print(bonus.checkBrackets("9*(11-6)+44)/2"));

}