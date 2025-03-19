/**
 * Klasse "User", dient nur zur (lokalen) Sicherheit mit Passwortschutz
 * (thoretisch braucht der Benutzer garkeinen Passwortschutz! Ist aber MVP...)
 */
final class UserData {
  final String? id; // für Datenbank ... wird dann auch nicht benötigt???
  final String username;
  final String currency; // Standard-FIAT des Nutzers

  UserData({required this.id, required this.username, this.currency = "EUR"});
}
