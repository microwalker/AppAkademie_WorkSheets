/**
 * Klasse "User", dient nur zur (lokalen) Sicherheit mit Passwortschutz
 */
final class User {
  String? id; // für Datenbank
  String username;
  bool? isAuthentificated = false;
  
  User(this.username);

  factory User.fromMap(Map m) => User(m["name"]) ..id = m["id"] ..isAuthentificated = m["is_authentificated"];

  bool get isIdentified => this.id != null;

  String toString() => "User(ID: $id, Name: $username)";
}
