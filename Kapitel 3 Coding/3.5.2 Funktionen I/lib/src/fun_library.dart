abstract class SimpleFunctions {
  static void printNumber(int number) => print(number);

  static void triplePrint(String text) => print(text * 3);

  static void reverseInitials(String forename, String lastname) {
    print(forename[forename.length-1].toUpperCase() + ". " + lastname[lastname.length-1].toUpperCase() + "."); }
}
