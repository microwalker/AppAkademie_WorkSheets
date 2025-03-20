/**
 * Klasse "User", dient nur zur (lokalen) Sicherheit mit Passwortschutz
 */
final class User {
  String? id; // für Datenbank
  String username;
  String currency = "eur"; // Standardeinstellung der, vom User genutzen, Währung

  User(this.username, [this.currency = "eur"]);

  bool get isIdentified => this.id != null;

  String toString() => "User(ID: $id, Name: $username, Currency: $currency)";
}
