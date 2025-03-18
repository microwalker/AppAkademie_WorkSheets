/**
 * Klasse "User", dient nur zur (lokalen) Sicherheit mit Passwortschutz
 */
final class User {
  String? _id; // für Datenbank
  String _username;
  String _currency = "EUR"; // Standardeinstellung der, vom User genutzen, Währung

  String get username => this._username;
  set username(String name) => this.username = name;

  String get id => this._id ?? "";
  set id(String id) => this._id = id;

  String get currency => this._currency;
  set currency(String currency) => this.currency = currency;

  bool get isIdentified => this._id != null;

  User(this._username, {currency = "EUR"}) { this._currency = currency; }

  String toString() => "User($_username, $_currency)";
}
