import 'lib/fun_lib.dart';

void main(List<String> args) {
  // Bonusaufgabe 1
  [185,421,67].forEach((mins) => BonusFunctions.convertMinutesToTime(mins));

  // Bonusaufgabe 2
  BonusFunctions.analyzeGrades([2,1,3]);

  // Bonusaufgabe 3
  BonusFunctions.analyzeNumbers([8, 21, -4, 99, 48, -15, 8, 76, 21, 0]);
}