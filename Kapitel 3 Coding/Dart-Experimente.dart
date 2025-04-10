// ® 07.02.25 Björg Schneider
// Allererstes DART-Programm
// (Test der Aufzählungsklasse)

// Wichtige Zeichen:
// | - Option 7
// {/} - Option 8/9
// [/] - Option 5/6
// @ - Option L
// \ - Shift Option 7

// Wichtige ShortCuts:
// Command S - Speichern
// Option Command S - Alles Speichern
// Shift Command 7 - Line Comment

// (Fn) F9 (oder mit der Maus setzen!) - Toggle Breakpoint 
// (Fn) F5 - Run Debug

import 'dart:math';
import 'dart:io';
import './3.5.4 P10 Komplexes Konsolenprogramm/lib/src/ansi.dart';

void main(List<String> args) {
  print("Gestartet...");
  
  // Auswertung der Konsolenargumente
  if(args.length>0) 
    args.forEach( (arg) => print(arg));
  else
    print("No Arguments given!");

  Runes();

  StringLists();

  TestWithClasses();

  BinaryOperators();

  LINQandLambda();

  testMath();
  
  charCodes();

  testWithAssert();

  ListsAndMaps();

  maxIntAndBigInt();
  
  shortFor();

  Lotto();


  // romanConverter();

  List<dynamic> l = [1,"hallo",true,["hallo"]];
  print(l);

  print("\nReady!");

}

void testWithAssert() {
  int d = 2;
  d = d += 5;
  d *= d != 3 ? ++d : d--;
  print(d);
  bool f = 3 == true;
  assert(f==false);
  bool g = "8" == "6";
  assert(g==false);
}

void romanConverter() {
  // I=1, V=5, X=10, L=50, C=100, D=500, M=1000.
  Map<String, int> romanDigits = {"M":1000,"D":500,"C":100,"L":50,"X":10,"V":5,"I":1};
  String rz = "MCMXCV";
  rz.toUpperCase();
  
  int val = 0; // Gesamtergebnis
  int p1 = 0; // aktuelle Pos
  int p2 = 0; // Pos Zwischenspeicher
  while(p1 + 1 < rz.length) {
    int z = romanDigits[rz[p2]]!;
    int zs = 0;
    p2 = p1;
    while(p2 + 1 < rz.length) {
      if(romanDigits.keys.contains(rz[p2]) && romanDigits[rz[p2]]! >= romanDigits[rz[p2+1]]!)
        zs += romanDigits[rz[p2]]!; // Zahl ist grösser gleich der nächsten Zahl => addieren
      else if(romanDigits[rz[p2]]! < romanDigits[rz[p2+1]]!)
        zs = romanDigits[rz[p2 + 1]]! - zs; // Zahl ist kleiner als die Folgezahl => zs von Folgezahl subtrahieren
      p2++;
      val+=zs;
      zs=0;
    }
    z = z;
  }
  print(val);
}

void charCodes() {
  print("\n\nString (+ as Array):");
  String s = "dsf msopsmdfm spd m";
  print(s[7] + " = " + String.fromCharCode(s.codeUnitAt(7)));
}

void testMath() {
  print("\n\nMATH-Library:");
  double m = 137.4;
  int t = 4;
  print("${pow(m,t)}");
}

void LINQandLambda() {
  /* Tests mit LINQ unter DART
     ========================= */
  print("\n\nLISTS:");
  List<int> zl = [1,2,3,4,5,6,7,9];
  List<int> z2 = [3,4,6,7,9,11];
  zl.forEach((element) => print(element*3)); // Simple innere Lambda-Funktion
  print("9 ist ${!zl.contains(9)?"nicht":""} vorhanden");
  
  print("\n\nLINQ in LISTS:");
  List<int>? tmpList; 
  tmpList = zl.where((element) => !z2.contains(element)).toList(); // Liste aller Elemente aus zl, die nicht in z2 sind
  print("Elemente, die in zl, aber nicht in z2 sind: $tmpList");
  tmpList = zl.where((element) => z2.contains(element)).toList(); // Alle Elemente, die sowohl in zl als auch in z2 sind
  print("Elemente, die sowohl in zl als auch z2 vorhanden sind: ${tmpList}");
  tmpList = z2.where((element) => element > 5).toList(); // Alle Elemente, die in z2 und größer als 5 sind
  print("${tmpList.length} Elemente aus Liste z2 ($z2) sind größer als 5: $tmpList");
  
  print("\n\nMAPS:");
  Map<int, dynamic> tmpMap = {1:"Gargel", 4:30.5, 5:[3,6,9], 11:{"Apfel":"rot"}};
  print("Map-Object: ${tmpMap[7] == null ? "Nix" : tmpMap[7]}");
  tmpMap.forEach((x,y) => print("$x = ${y.runtimeType}"));
}

void BinaryOperators() {
  Gruppe ng = Gruppe.fromString(name: "Leute",liste: "Bärbel, Renate, Hans", separator: ",");
  
  // Tests mit biären Operatoren
  print(((ng.hexZahl + 0x000001) & 0xffffff | 0xc0c0c0).toRadixString(2)); // Hex-Berechnung mit Binärausgabe
  print("${(0x003399dd).toRadixString(2)} [SHIFT LEFT * 3] => ${(0x003399dd<<3).toRadixString(2)}"); // entspricht Wert * 8
  
  ng.hexZahlFilled = (ng.hexZahl > 0 ? true : false); // Konditionale Zuweisung
  // entspr. ng.hexZahlFilled = ng.hexZahl > 0; (Zuweisung unnötig...)
}

void Runes() {
  // Runes (Smileys etc.)
  String tmpStr = "😂👍😱🥱";
  print(tmpStr + ": ");
  tmpStr.codeUnits.forEach((r) => print("0x" + r.toRadixString((16))));
}

void TestWithClasses() {
  // Test mit separater Testklasse "Gruppe"
  Gruppe ng = Gruppe.fromString(name: "Leute",liste: "Bärbel, Renate, Hans", separator: ",");
  ng.addMember("Sabine");
  ng.removeMember("Horst");
  ng.addMember("Horst");
  print(ng.toString());
  
  ng.sortMembers();
  print(ng.toString());
  
  Gruppe ng2 = Gruppe("Test", ["Udo", "Petra"].toList());
  ng2.GruppenName = "Alte Leute";
  print("$ng2"); // inline-Ausgabe über 'indirekte' toString()-Funktion
}

void StringLists() {
  // Test mit "Standard"-Listendatentyp
  List<String> test = new List<String>.from( {"Klaus", "Susi", "Frank"} );
  var line = "Namen: " + test.join(", ");
  line += ". Gelistet am " +  DateTime.now().toString();
  print(line);
}

void ListsAndMaps() {
  List<double> li = [4.3,8.9,3.7]..sort();
  print(li);

  List<Map<String, dynamic>> myMapList = [{"Name": "Evigenios", "Wert": 123.45, "Email": "evigenios@abc.de"},{"Name": "Klaus", "Wert": 543.21, "Email": "klaus@abc.de"}];
  myMapList.add({"Name": "Hannes", "Wert": 8765.43, "Email": "hannes@abc.de"});
  
  for(Map m in myMapList) {
    print("${m["Name"]} hat die Email '${m["Email"]}' und ${m["Wert"]} € in der Tasche!");
  }
  
  Map<String, int> mn = {"a":1, "b":2, "c":3, "d":4};
  for(String s in mn.keys) { print("$s: Note ${mn[s]}"); }
  mn.forEach((key, value) => print("$key hat $value Punkte"));
}

void maxIntAndBigInt() {
  int x = 0x7fffffffffffffff;
  print(x);
  print(x+1); // Umkehr des Maximalwerts von int64 ins Negative nach erneuter Inkrementierung !!!
  
  // Test innerhalb einer Schleife:
  int i=0;
  while(i>=0) {
    i += 0x0400000000000000;
    print("While-Schleife: $i (Hex: 0x${i.toRadixString(16).padLeft(16,"0")})");
  }
   
  BigInt big = BigInt.from(i);
  print(big); // noch -9.223.372.036.854.775.808 
  print("0x${big.toRadixString(16)}");
  print(big*=big); // Erg.: 85.070.591.730.234.615.865.843.651.857.942.052.864 (Positiv, das Minus*Minus=Plus !!!)
  print("0x${big.toRadixString(16)}");
  print(big*=big); // Erg.: 7.237.005.577.332.262.213.973.186.563.042.994.240.829.374.041.602.535.252.466.099.000.494.570.602.496
                   //     12a 12o 11a 11o 10a 10o  9a  9o Oka Oko Spa Spo Sxa Sxo Qia Qio Qua Quo Tra Tro Bil Bio Mil Mio Tsd Hdt
                   //     Dodez.  Undez.  Dezill. Nonill. Oktill. Septil. Sextil. Quint.  Quadr.  Trill.  Bill.   Mill.    T   H
  print("0x${big.toRadixString(16)}");
  // maxWert in64: 9.223.372.036.854.775.807 
  //              (9 Trillionen, 223 Billiarden, 372 Billionen, 36 Milliarden, 854 Millionen und ein paar Zerditschte...)
  // ...alles, was darüber ist, muss mit BigInt gehandled werden!!!
}

void shortFor() {
  int i=0;
  for(i=0; i<5; i++) print(i);
  print(i);
  
  i=0;
  for(i=0; i<5; ++i) print(i);
  print(i);  
  
}

void Lotto() {
  // Real Lotto Simulation
  // List<int> zahlen = [1,2,3,4,5,6,7,....49];
  List nums = List.generate(49, (int index) => index + 1 );
  print(nums);
  
  List nums2 = [...nums];
  nums2.length = 49; // bei mehr als 49 würde der Rest mit Null gefüllt...
  print(nums2);
  nums2[nums2.indexOf(16)] = 0;
  
  List nums3 = [for(int i=1; i<50; i++) i];
  print(nums3);
  
  List ergs = [];
  print(nums);
  for(int j = 0; j < 7; j++) {
    final int mix = Random().nextInt(25); // mix * Mischen, max. 25 mal
    for(int i = 0; i < mix; i++) {
      nums.shuffle(); // nur nums.shuffle(m) ???
      print(nums); }
    ergs.add(nums.last);
    nums.removeLast();
    print("Ausloste Zahlen: $ergs");
  }
  // print(ergs);
  ergs.forEach((element) {
    print("${element == ergs.last ? "Zusatzzahl: ":"${ergs.indexOf(element)+1}. Zahl: "}$element");
  });
  
  print("\n\nLotto (V1) für Evigenois:");
  int Anzahl1 = 49;
  List<int> zahlen = [];
  for(int i = 1; i <= Anzahl1; i++) {
    zahlen.add(i);
  }
  print(zahlen);
  for(int i = 0; i < 7; i++) {
    bool zahlgueltig = false;
    while(zahlgueltig == false) {
      int gezZahl = Random().nextInt(Anzahl1) + 1; // Random liefert (bei 49) 0 bis 48 => +1 = 1 bis 49
      print("Zufällig: $gezZahl");
      for(int j = 0; j < zahlen.length; j++)
        if(zahlen[j] == gezZahl) {
          print("$gezZahl ist die ${i==6?"Zusatzzahl":"${i+1}. Zahl"}");
          zahlen.remove(gezZahl);
          zahlgueltig = true;
        }
    }
  }
  
  print(ANSI_Erasing.ERASE_ENTIRESCREEN);
  String ansi = setANSI_ForegroundColour256(62);
  ansi += setANSI_TextMode(ANSI_TextModes.ITALIC);
  // ansi += getANSISequence(ANSI_SetScreenMode, values: [ANSI_ScreenModes.COLOR_640X480_GFX_16C]);
  print(ansi + "Lotto (V2) für Evigenois:" + resetAllANSI_TextModes());
  List<int> gezZahlen = [];
  for(int i = 0; i < 7; i++) {
    bool zahlgueltig = false;
    while(zahlgueltig == false) {
      int gezZahl = Random().nextInt(49) + 1; // Random liefert (bei 49) 0 bis 48 => +1 = 1 bis 49
      print("Zufällig: $gezZahl");
      
      zahlgueltig = true;
      for(int j = 0; j < gezZahlen.length; j++)
        if(gezZahlen[j] == gezZahl) {
          print("Die $gezZahl wurde schon gezogen. Nochmal!");
          zahlgueltig = false;
        }
      
      if(zahlgueltig == true) {
        print("$gezZahl ist die ${i==6?"Zusatzzahl":"${i+1}. Zahl"}");
        gezZahlen.add(gezZahl);
      }
    }
  }
  print(gezZahlen);
}

String getInput(String statement) {
  if(stdin.hasTerminal) {
    stdout.write(statement + "? ");
    return stdin.readLineSync() ?? "";
  } else {
    print("Bitte starten Sie das Programm im Terminal um Eingaben zu ermöglichen");
    return "J";
  }
}

// Testklasse "Gruppe" 
class Gruppe {
  // Membervariablen
  String _GruppenName = "";
  List<String> _Namen = List<String>.empty();
  int hexZahl = 0xFFFFFF;
  bool hexZahlFilled = false;
  String? maybeNull;
  
  // Getter/Setter
  get Count => _Namen.length;
  set GruppenName(String value) => _GruppenName = value;

  // Constructor
  Gruppe(this._GruppenName, this._Namen, {this.maybeNull});

  // named Constructors
  Gruppe.noNames(this._GruppenName) {
    this._Namen=List.empty();
  }

  Gruppe.empty() {
    this._Namen = new List<String>.empty();
    this._GruppenName = "";
    this.maybeNull = "not empty"; 
  }
  
  // named Constructor mit benannten Parametern und try/catch-Errorhandling
  Gruppe.fromString({String name = "", String liste = "", String separator = ","}) {
    try {
      this._GruppenName = name;
      this._Namen = List<String>.from(liste.split(separator));
      this._Namen.forEach(print); // HINT: TRIM funktioniert nicht!!! ???
      // if(this._Namen.length>0) 
      //   for(int i=0;i<this._Namen.length;i++) _Namen[i] = _Namen[i].trim(); // <= DAS geht !!! Merkwürdig...
    } catch(e) {
      print("Fehler $e beim Erstellen der Gruppe '$name'");
      rethrow;
    }
  }

  // Funktionen
  void addMember(String name) {
    _Namen.add(name);
  }

  bool removeMember(String name) {
    if(_Namen.contains(name)) 
      return _Namen.remove(name);
    else {
      print("$name nicht vorhanden, kann also nicht gelöscht werden!");
      return false;
    }
  }

  void sortMembers() {
    _Namen.sort();
  }

  String toString() {
    return "Gruppe: $_GruppenName\nMitglieder: $Count\nNamen: $_Namen";
  }

}

