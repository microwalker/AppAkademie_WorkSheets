void main(List<String> args) {
  aufg1();
  bonusAufg1();
  bonusAufg2();

  const String str = "Hallo, mein Name ist %name%!";
  String name = "Klaus";
  print(str.replaceAll("%name%", name));
}

void aufg1() {
  print("\nAufgabe 1)");
  List<int> a = [1, 3, 10, -4];
  List<bool> b = [true, true, false];

  int x = 5;
  int y = 23;
  List<int> c = [x, x + 1, x + y]; // Inhalt: [5, 6, 28]
  print(c);

  List<int> d = [c[0], c[0]]; // Inhalt: [5, 5]
  print(d);

  Map<int, bool> m = {1: true, 2: false, 3: true, 4: false};
  print(m);

  Map<int, bool> n = {c[2]: b[2]}; // Inhalt: {28: false}
  print(n);

  // List<int> e = [a[10] * d[1]];  // FEHLER, kein 11. Element vorhanden
  // print(e);
}

void bonusAufg1() {
  print("\nBonus-Aufgabe 1)");
  String a = "A11"; 
  String b = "A23"; 
  List<String> myList = [a, b]; 
  Map<String, String> myMap = {myList[0]: "Lorem", myList[1]: "Ipsum"}; 
  print("${myMap[myList[0]]}_${myMap[myList[1]]}${a}_${b[0]}${a[0]}");
}

void bonusAufg2() {
  print("\nBonus-Aufgabe 2)");
  List<List<List<Map<String, int>>>> myList = [
    [
      [
        {"Alpha": 24},
      ],
      [
        {"Beta": 25},
      ],
    ],
    [
      [
        {"Alpha": 34},
      ],
      [
        {"Beta": 35},
      ],
    ],
    [
      [
        {"Alpha": 44},
      ],
      [
        {"Beta": 45},
      ],
    ],
    [
      [
        {"Alpha": 54},
      ],
      [
        {"Beta": 55},
      ],
    ],
    [
      [
        {"Alpha": 64},
      ],
      [
        {"Beta": 65},
      ],
    ],
  ];

  print(myList);
  int erg = myList[0][0][0]["Alpha"]! + myList[1][0][0]["Alpha"]! + myList[2][0][0]["Alpha"]! - myList[0][1][0]["Beta"]!;

  // myList[0][0][0]["Alpha"] + myList[1][0][0]["Alpha"] + myList[2][0][0]["Alpha"] - myList[0][0][0]["Beta"]; 
  print(erg);

  try {
    print(myList[0][0][0]["Alpha"]! + myList[1][0][0]["Alpha"]! + myList[2][0][0]["Alpha"]! - myList[0][0][0]["Beta"]!);
  } catch(e) {
    print("Error: $e");
  }
}