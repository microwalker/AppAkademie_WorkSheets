/**
 * Klasse "Account" wird benötigt, um Transaktionen für einen Coin zu sammeln... 
 * wird aber ggf. doch durch eine einfache Liste ersetzt!?!?
 */
class Account {
  final String? id; // KontoID für FireStore-Datenbank
  final String userId;
  final String name;
  final String coinId; // entspricht der Coin.id aus dem Datenimport
  final String currency;

  Account({required this.id, required this.userId, required this.name, required this.coinId, required this.currency}); // für Datenbank

  factory Account.fromMap(String userId, Map<String, dynamic> m) => Account(
      id: m["id"], 
      userId: m["user_id"],
      name: m["name"], 
      coinId: m["coin_id"], 
      currency: m["currency"]) ;

  @override
  String toString() => "Account($id, $userId, $name, $coinId, $currency)";
}
