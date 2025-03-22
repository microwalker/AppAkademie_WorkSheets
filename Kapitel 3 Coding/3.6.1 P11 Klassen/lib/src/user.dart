/**
 * Klasse "User", dient nur zur (lokalen) Sicherheit mit Passwortschutz
 */
final class User {
  String? id; // für Datenbank
  String username;
  
  User(this.username);

  bool get isIdentified => this.id != null;

  String toString() => "User(ID: $id, Name: $username)";
}
