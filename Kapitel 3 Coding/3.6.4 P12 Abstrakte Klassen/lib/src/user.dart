/**
 * Klasse "User", dient nur zur (lokalen) Sicherheit mit Passwortschutz
 */
final class User {
  final String? id; // für Datenbank
  final String username;
  final bool? isAuthentificated = false;
  
  User({required this.id, required this.username});

  factory User.fromMap(Map<String, dynamic> m) => User(id: m["id"], username: m["name"]);

  bool get isIdentified => this.id != null;

  String toString() => "User(ID: $id, Name: $username)";
}
