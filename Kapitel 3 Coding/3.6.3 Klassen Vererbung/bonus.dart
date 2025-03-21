void main() {
  bonusAufg1();
  bonusAufg2();
}

void bonusAufg1() {
  List<Tool> tools = [Hammer(HammerType.Vorschlaghammer, 2500, "Zerstörer", false)];
  tools.add(Saw("Wood", "Baumvernichter", false));
  Saw s = Saw("Bones", "Der Zerteiler", false);
  Hammer h = Hammer(HammerType.Zimmermannshammer, 300, "Tischi 😜", false);
  tools.addAll([s, h]);

  for(Tool t in tools) t.use();
}

class Tool {
  bool isElectrical;
  String name;

  Tool(this.name, this.isElectrical);

  void use() => print("Using my Cool Tool '$name'");
}

enum HammerType { Zimmermannshammer, Vorschlaghammer }

final class Hammer extends Tool {
  int weight;
  HammerType type;

  Hammer(this.type, this.weight, super.name, super.isElectrical);

  // try without @override: Wird scheinbar automatisch überschrieben !?!?
  void use() => print("Using $name with $weight g: bam, bam bam...");
}

final class Saw extends Tool {
  String whatFor;

  Saw(this.whatFor, super.name, super.isElectrical);
  
  @override
  void use() => print("Using $name for $whatFor: sawing now... (legs, arms... 🫣)");
}

void bonusAufg2() {
  List<Grocery> articles = [Milk(1000, "H-Milch", "Hansano", 1047, 1.09)]; 
  Butter b = Butter("Deutsche Butter", "Hansano", 250, 2.29);
  articles.add(b);

  articles.forEach((e) => print(e.pricePerKg()));
}

// schlechtes Besipiel, da eher Artikelliste... alle Vererbungen wären auch nur Artikel
class Grocery {
  String name;
  String producer;
  int weight; // in Gramm
  double price;

  Grocery(this.name, this.producer, this.weight, this.price);

  /// Preis pro Kilogramm
  double pricePerKg() => (1000 / weight) * price;
}

class Milk extends Grocery {
  double millilitres;

  Milk(this.millilitres, super.name, super.producer, super.weight, super.price);

  // mir fällt nix ein, was Milch "overriden" könnte... Ideenblockade???
}

class Butter extends Grocery {
  bool needCooling = true;

  Butter(super.name, super.producer, super.weight, super.price);


  // mir fällt nix ein, was Milch "overriden" könnte... Ideenblockade???
}