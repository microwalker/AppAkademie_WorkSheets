import 'dart:io';

void main() {
  bonusAufg1();
  bonusAufg2();
}

void bonusAufg1() {
  List<String> words = ["otto","anna","rentner","Kajak","Kartoffel","Lagerregal","Google","Neffen"];
  for(String word in words) {
    print("'$word' ist ${isPalindrom(word)?"ein":"leider kein"} Palindrom.");
  }
}

void bonusAufg2() {
  List<int> zahlen = [5, 14, 7, 2, 9];
  for(int zahl in zahlen) {
    printForwardAndBackAgain(zahl);
  }
}

bool isPalindrom(String word) {
  String reversedWord = "";
  for(int i=word.length;i>0;i--) {
    reversedWord += word[i-1];
  }
  return reversedWord.toLowerCase() == word.toLowerCase();
}

void printForwardAndBackAgain(int zahl) {
  String fb = "";
  for(int i=1;i<=zahl;i++) {
    fb += "$i ";
  }
  for(int i=zahl-1;i>0;i--) {
    fb += "$i ";
  }
  print(fb);
}