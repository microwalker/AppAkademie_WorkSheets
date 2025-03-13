import 'lib/functions.dart';

void main(List<String> args) { 
  // Aufgabe 1
  print(easy.sum(1, 2, 3));
  print(easy.sum(10, 15, 20));
  print(easy.sum(5, 10, 15));

  // Aufgabe 2
  print("${easy.len("Dies ist ein Text")} Buchstaben");
  
  // Aufgabe 3
  print("${easy.vocals("das schaf auf der grünen wiese... hurz!")} Vokale");

  print(bonus.toHMS(345435));
  print(bonus.isAnagram("Ort", "Tor"));
}