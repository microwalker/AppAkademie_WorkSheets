void main(List<String> args) {
  aufg1();
  bonusAufg1();
  bonusAufg2();

  const String str = "Hallo, mein Name ist %name%! Ihr könnt mich einfach %name% nennen 😂...";
  String name = "Klaus";
  print(str.replaceAll("%name%", name));
}

void aufg1() {
  print("\nAufgabe 1)");
  List<int> a = [1, 3, 10, -4];
  List<bool> b = [true, true, false];

  print(a); // just for being used!

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
    [ // 0 
      [ // 0 0
        {"Alpha": 24}, // 0 0 0 + key
        {"Alpha": 31, "Beta": 4} // 0 0 1 + key
      ],
      [ // 0 1
        {"Beta": 25}, // 0 1 0
      ],
    ],
    [ // 1
      [ // 1 0
        {"Alpha": 34}, // 1 0 0 + key
      ],
      [ // 1 1
        {"Beta": 35}, // 1 1 0 + key
      ],
    ],
    [ // 2
      [ // 2 0
        {"Alpha": 44}, // 2 0 0 + key
      ],
      [// 2 1
        {"Beta": 45}, // 2 1 0 + key
      ],
    ],
    [ // 3
      [ // 3 0
        {"Alpha": 54}, // 3 0 0 + key
      ],
      [ // 3 1
        {"Beta": 55}, // 3 1 0 + key
      ], 
    ],
    [ // 4 
      [ // 4 0
        {"Alpha": 64}, // 4 0 0 + key
      ],
      [ // 4 1
        {"Beta": 65}, // 4 1 0 + key
      ],
    ],
  ];
  print(myList[0]); // 0 - 4 
  print(myList[0][0]); // 0 - 1
  print(myList[0][0][0]); // 0 (- 1 nur in myList[0][0] !)

  print(myList[0][0][1]["Beta"]!);
  // print(myList[0][0][0].map((key, value) { print("$key = $value")}));
  
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