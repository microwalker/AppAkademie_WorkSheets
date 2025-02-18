void main(List<String> args) {
  String c = "Schöne";
  String dd = "!"; // Variablenbezeichnung nach Ansage auf dd geändert!
  String dayStr = "Tag";
  String gdStr = "Guten";
  String morning = "Morgen";
  String s = "Heute";
  String spa = " ";
  String timeStr = "Zeit";
  String worldStr = "Welt";
  
  int a = 24;
  int d = 20; // wurde vor Änderung (s.o) schon als String-Variable verwendet! Absicht?
  int seven = 7;
  int twelve = 12;

  String tmpString = gdStr + spa + dayStr + spa + worldStr + dd;
  print(tmpString);

  print(a+seven);

  tmpString = c + spa + timeStr + dd;
  print(tmpString);

  tmpString = s + spa + morning + dd;
  print(tmpString);

  print(a*seven);
}