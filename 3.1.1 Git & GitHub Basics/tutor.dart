class tutor {
  String name = "";
  List<String> _faecher = new List<String>.empty(growable: true);

  void addFach(String fach) {
    this._faecher.add(fach);
  }

  String toString() {
    return "$name für $_faecher";
  }
}