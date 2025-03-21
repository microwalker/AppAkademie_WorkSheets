void main() {
  bonusAufg2();
  bonusAufg3bis5();
  bonusAufg6();
}

void bonusAufg2() {
  Button b = Button("In den Warenkorb", width: 96, height: 32, radius: 4, fontSize: 14, padding: 8);
  print(b.text);
}

void bonusAufg3bis5() {
  Rect r = Rect(4, 7);
  print(r);
  print("Fläche: ${r.area()}");
  print("Umfang: ${r.perimeter()}");
  
  r.x = 9;
  print(r);
  print("Fläche: ${r.area()}");
  print("Umfang: ${r.perimeter()}");

  r.scale(0.5); // => Pixelverlust beim Scalieren (toInt)
  print(r);
  print("Fläche: ${r.area()}");
  print("Umfang: ${r.perimeter()}");

  r.scale(2); // => Pixelverlust beim Scalieren (toInt)
  print(r);
  print("Fläche: ${r.area()}");
  print("Umfang: ${r.perimeter()}");
}

void bonusAufg6() {
  Author a = Author("A. Fichtenblink");
  Book b = Book(a, "Das Fallen im Walde") ..pages = 12;
  print("Titel: ${b.title} von ${b.author.name} (${b.pages} Seiten)");
}

class Button {
  final String text;
  final int width;
  final int height;
  final int? radius;
  final int? fontSize;
  final int? padding;
  Button(this.text, {required this.width, required this.height, this.radius, this.fontSize, this.padding}); // …in der Annahme, dass Button die Nullables selbst berechnet 🙂
}

class Rect {
  int x;
  int y;

  Rect(this.x, this.y);

  int perimeter() => (x+y)*2;
  int area() => x*y;

  void scale(double factor) => this ..x = (x * factor).toInt() ..y = (y * factor).toInt(); // …in der Annahme, das es sich um ein darstellbares Rechteck in Pixeln handelt...

  String toString() => "Rect($x, $y)";
}

class Author {
  String name;
  int? yearOfBirth;
  Author(this.name, [this.yearOfBirth]);
}

class Book {
  Author author;
  String title;
  int? pages;
  Book(this.author, this.title, [pages]);
}