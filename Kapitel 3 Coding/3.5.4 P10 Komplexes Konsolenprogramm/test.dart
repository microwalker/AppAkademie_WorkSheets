import 'lib/src/bookings.dart';

void main() {
  // Instanzierung
  cEntries l = cEntries();

  // Mothoden
  l.add(Soll(DateTime.parse('2025-03-17'), "Einnahme", 345.67));
  l.add(Haben(DateTime.parse('2024-11-06'), "Ausgabe", 765.43));
  
  // Ausgaben (indirekt toString())
  print(l);
  print(l.length);

  // Zuweisung
  cEntries l2 = cEntries();
  l2 = l;

  // LINQ
  l.forEach((element) => print(element));

  // LINQ + Lambda
  double saldo = l.fold(0.0, (p, e) => p += e.value);
  print("SALDO: $saldo");
}