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
  // oder:
  print(gdStr + spa + dayStr + spa + worldStr + dd);
  // oder:
  print("$gdStr$spa$dayStr$spa$worldStr$dd");

  print(a+seven);

  tmpString = c + spa + timeStr + dd;
  print(tmpString);
  // oder:
  print(c + spa + timeStr + dd);
  // oder:
  print("$c$spa$timeStr$dd");

  tmpString = s + spa + morning + dd;
  print(tmpString);
  // oder:
  print(s + spa + morning + dd);
  // oder:
  print("$s$spa$morning$dd");

  print(a*seven);

  print(d|twelve); // ...damit die Variablen auch endlich mal verwendet werden und der Analyzer aufhört, zu meckern :-)

  aufg2a();
  aufg2b();
  aufg2c();
  aufg2d();

  test(5);
}

void aufg2a() {
  String a = "Apfel";
  String b = "Birne";
  String c = "Kirsche";
  String d = "Mango";
  b = c;
  d = a;
  c = d;
  a = b;
  d = c;
  b = d;
  
  print('\nAufgabe 2a)\nString a = "Apfel";\nString b = "Birne";\nString c = "Kirsche";\nString d = "Mango";\n\nb = c;\nd = a;\nc = d;\na = b;\nd = c;\nb = d;');
  print('Ergebnisse: a="$a" b="$b" c="$c" d="$d"\n');
}

void aufg2b() {
  String x = "Java";
  String y = "Python";
  String z = "Ruby";
  String w = "Kotlin";
  String v = "Swift";

  w = x;
  v = w;
  x = y;
  y = z;
  z = v;
  v = w;
  w = y;

  print('\nAufgabe 2b)\nString x = "Java";\nString y = "Python";\nString z = "Ruby";\nString w = "Kotlin";\nString v = "Swift";\n\nw = x;\nv = w;\nx = y;\ny = z;\nz = v;\nv = w;\nw = y;\n\n');
  print('Ergebnisse: x="$x" y="$y" z="$z" w="$w" v="$v"\n');
}

void aufg2c() {
  int a = 100;
  int b = 200;
  int c = 300;
  int d = 400;
  int e = 500; 

  c = a;
  e = b;
  a = d;
  b = c;
  d = e;
  c = b;
  e = a;

  print("\nAufgabe 2c)\nint a = 100;\nint b = 200;\nint c = 300;\nint d = 400;\nint e = 500;\n\nc = a;\ne = b;\na = d;\nb = c;\nd = e;\nc = b;\ne = a;\n\n");
  print("Ergebnisse: a=$a b=$b c=$c d=$d e=$e\n");
}

void aufg2d() {
  int x = 42;
  int y = 55;
  int z = 89;
  int w = 73;
  int v = 91;
  int u = 64;

  w = x;
  u = y;
  x = v;
  y = z;
  v = w;
  z = u;
  w = y;
  u = v;

  print("\nAufgabe 2d)\nint x = 42;\nint y = 55;\nint z = 89;\nint w = 73;\nint v = 91;\nint u = 64;\n\nw = x;\nu = y;\nx = v;\ny = z;\nv = w;\nz = u;\nw = y;\nu = v;\n\n");
  print("Ergebnisse: x=$x y=$y z=$z w=$w v=$v u=$u\n");
}

void test(int zahl) {
  String xyz = "uhodfghnsdfuogh";
  int laenge = xyz.length;
  String teil = xyz[zahl];

  print("Michael ist " + zahl.toString() + " Jahre alt :-)...");

  String name = "Eberhardt";
  print("Hallo $name, wie geht es Dir. Heute ist der ...");

  List namen = ["Björg","Michael","David","Melike","Oskar","Pauline"];
  String deinName = namen[1];
  print("Hallo $deinName, schön dass Du da bist!");

  while(zahl < 20.1) {
    print("Jetzt ist die Zahl $zahl!");
    zahl++; 
  }

  if(zahl == 20)
  {
    print("Zahl ist 20 !!!");
  }
  /*
  else 
  {
    print("Zahl ist NICHT 20!");
  }
  */ 

  print("Ich habe Fertig!");
}