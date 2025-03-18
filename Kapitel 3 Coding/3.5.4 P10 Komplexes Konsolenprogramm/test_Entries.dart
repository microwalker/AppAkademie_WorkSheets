import 'lib/src/entries.dart';

void main() {
  // Instanzierung
  Entries l = Entries();

  // Mothoden
  l.add(Soll(DateTime.parse('2025-03-17'), "Einnahme", 345.67));
  l.add(Haben(DateTime.parse('2024-11-06'), "Ausgabe", 765.43));
  
  l.sortByDate();

  // Ausgaben (indirekt toString())
  print(l);
  print(l.runtimeType);

  // Zuweisung
  Entries l2 = Entries();
  l2 = l;

  // LINQ
  l.forEach((element) => print(element));

  DateTime sDate = DateTime(2024, 12, 31);
  print("Saldo am $sDate = " + l2.getSaldoAtDate(sDate).toStringAsFixed(2));

  // LINQ + Lambda
  double saldo = l.fold(0.0, (p, e) => p += e.value);
  print("SALDO (Heute, am ${DateTime.now()}): $saldo");
}