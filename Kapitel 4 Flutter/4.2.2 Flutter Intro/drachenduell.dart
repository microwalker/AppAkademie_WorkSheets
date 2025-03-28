// Team 4: 
// Davut Coskun
// Simon Isinger
// Björg Schneider

// Aufgabe Drachenduell

void main() {
  Dragon dragon1 = Dragon(name: "Inferno", firePower: 100);
  Dragon dragon2 = Dragon(name: "FrostWing", firePower: 80);

  print("Vorher: ${dragon1.name}: ${dragon1.firePower}, ${dragon2.name}: ${dragon2.firePower}");

  attack(dragon1, dragon2);

  rest([dragon1, dragon2]);

  attack(dragon1, dragon2);
}

void attack(Dragon src, Dragon target) {
  src.breatheFire(target);
  target.breatheFire(src);

  print("After Attack: ${src.name}: ${src.firePower}, ${target.name}: ${target.firePower}");
}

void rest(List<Dragon> dragons) {

  for(Dragon d in dragons) {
    d.rest();
    print("Rested: ${d.name}: ${d.firePower}");
  } 
}

// Diese Funktion nur zur Demonstration:
void restLambdaLINQ(List<Dragon> dragons) => dragons.forEach((d) { d.rest(); print("Rested: ${d.name}: ${d.firePower}"); });

class Dragon {
  final String name;
  int firePower;

  Dragon({required this.name, required this.firePower});

  int breatheFire(Dragon target) {
    firePower -= firePower >=20 ? 20 : firePower;

    int damage = target.firePower >=15 ? 15 : target.firePower;
    target.firePower -= damage;

    return damage;
  }

  void rest() => firePower += firePower <= 80 ? 20 : 100-firePower;
}
