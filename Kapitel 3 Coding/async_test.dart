import 'dart:io';

void main(List<String> args) {
  doIt1();

  doIt2();

  doIt3();

  doIt4();
}

Future doIt1() async {
  print("start");
  sum(10, 20, 5).then((value) => print("Value: $value"));
  print("fertig #1");
  sum(20, 40, 2).then((value) => print("fertig #2"));
  print("fertig #3");
  int c = await sum(5, 10, 1);
  print("Ergebnis $c");
  print("fertig #4");
}

void doIt3() async { print("Hallo"); }

Future<int> sum(int a, int b, int secs) async {
  Future.delayed(Duration(seconds: secs));
  int c = a + b;
  print(a + b);
  return c;
}

Future doIt2() async {
  Future.delayed(Duration(milliseconds: 500)).then((_) { print("A fertig!"); });
  Future.delayed(Duration(milliseconds: 100)).then((_) { print("B fertig!"); });
  await Future.delayed(Duration(milliseconds: 700)).then((_) { print("C fertig!"); });
  Future.delayed(Duration(milliseconds: 50)).then((_) { print("D fertig!"); });
  print("Fertig!");
}

Future<int> myFunction1() async {
  await Future.delayed(Duration(seconds: 5));
  return 200;
}


Future<int> myFunction2() async {
  Future.delayed(Duration(seconds: 3));
  return 500;
}


Future<void> myFunction3() async {
  Future.delayed(Duration(seconds: 12));
  print("Ready!");
}


Future<String> myFunction4() async {
  int x = await myFunction1();
  int y = await myFunction2();
  await myFunction3();
  return "${x + y}";
}


void doIt4() async {
  final Future<String> myFuture = myFunction4();
  String a = await myFuture;
  print(a);
}
