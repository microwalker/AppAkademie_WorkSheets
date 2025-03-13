// import der funKTIONSlibRARY (funlib)
import "lib/fun_lib.dart";

void main(List<String> args) {
  // Aufgabe 1:
  [7,11,4,19].forEach((number) => SimpleFunctions.printNumber(number)); 

  // Aufgabe 2:
  ["Gargel","Schraub","Würfel"].forEach((text) => SimpleFunctions.triplePrint(text)); 

  // Aufgabe 3:
  List<List<String>> names = [["Johnny","Depp"],["Tom","Cruise"],["Klaus","Kinski"]];
  for(List name in names)
    SimpleFunctions.reverseInitials(name[0], name[1]);
}

