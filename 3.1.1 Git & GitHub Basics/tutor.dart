class tutor extends nixtut {
  List<String> _faecher = new List<String>.empty(growable: true);

  tutor(String name) {super.name = name;}

  void addFach(String fach) {
    this._faecher.add(fach);
  }

  String toString() {
    return "$name für $_faecher";
  }
}
class nixtut {
  String name = "";
}