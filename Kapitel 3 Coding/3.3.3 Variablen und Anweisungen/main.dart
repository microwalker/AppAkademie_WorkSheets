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
  //oder:
  print(gdStr + spa + dayStr + spa + worldStr + dd);

  print(a+seven);

  tmpString = c + spa + timeStr + dd;
  print(tmpString);

  tmpString = s + spa + morning + dd;
  print(tmpString);

  print(a*seven);

  print(d/twelve); // ...damit die Variablen auch endlich mal verwendet werden und der Analyzer aufhört, zu meckern :-)

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
  
  print("Aufgabe 2a) $a $b $c $d");
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

  print("Aufgabe 2b) $x $y $z $w $v");
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

  print("Aufgabe 2c) $a $b $c $d $e");
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

  print("Aufgabe 2d) $x $y $z $w $v $u");
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