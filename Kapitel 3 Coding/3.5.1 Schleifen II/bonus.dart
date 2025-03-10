void main() {
  bonusAufg1();
}

void bonusAufg1() {
  List<String> words = ["otto","anna","rentner","Kajak","Kartoffel","Lagerregal","Google","Neffen"];
  for(String word in words) {
    print("'$word' ist ${isPalindrom(word)?"ein":"leider kein"} Palindrom.");
  }
}

bool isPalindrom(String word) {
  String reversedWord = "";
  for(int i=word.length;i>0;i--) {
    reversedWord += word[i-1];
  }
  return reversedWord.toLowerCase() == word.toLowerCase();
}