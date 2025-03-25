import 'account.dart';
import 'transaction.dart';

class UserData {
  String userID; // Instanz für den angemeldeten User (FireStore Authentification)
  List<Account> accounts = []; // Speichert die Konten für Coins und deren Transaktionen (FireStore)
  Set<String> favorites = {}; // Speichert die favorisierten Coins anhand ihrer ID (String) (FireStore)
  String userCurrency = "eur";
  bool hasToHold1Year = true;

  UserData({required this.userID});

  /*
{
  "user_id": "kfd98uz4odjf8844ß39jggj9043", 
  "hold_1year": true,
  "currency": "eur",
  "favorites": [
    "bitcoin","ethereum","iota","bonk","doge","shiba-inu"], 
  "accounts": [
    {"name": "Bitcoin (EURO)", "coin_id": "bitcoin", "currency": "eur", "transactions": []},
    {"name": "Bitcoin (USD)", "coin_id": "bitcoin", "currency": "usd", "transactions": []},
    {"name": "Ethereum", "coind_id": "ethereum", "currency": "eur", "transactions": []}] 
};  */
  factory UserData.fromMap(Map<String, dynamic> m) => UserData(userID: m["user_id"]) 
    ..userCurrency = m["currency"]
    ..favorites = { for(String s in m["favorites"]) s }
    ..accounts = [ for(Map<String, dynamic> a in m["accounts"]) Account.fromMap(a) ];

  // TODO: Favoriten aus FireStore holen
  // TODO: Accounts aus FireStore holen 
  // TODO: Currency (oder mehrere???) aus FireStore holen
  
  void addAccount(String name, String coinID, [String currency = "eur"]) {
     Account account = Account(this.userID, name, coinID, currency);
     // Speichern und ID ermitteln ...
     account.id = name; // TODO: name durch FireStore-ID ersetzen
     accounts.add(account);
  }

  void removeAccount(String accountId) {
    Account account = accounts.singleWhere((a) => a.id == accountId);
    // Löschen des Accounts in FireStore ...
    accounts.remove(account);
  }

  /// Prüft, ob ein Coin als Favorit gespeichert wurde
  bool isFavoriteCoin(String coinId) => favorites.contains(coinId);

  /// Alle Transaktionen (unsortiert, über alle Konten hinweg) als Liste zurückgeben
  List<Transaction> allTransactions() => this.accounts.fold([], (p, e) => p + e.transactions);

  /// Alle Transaktionen (unsortiert) für einen Coinzurückgeben (ggf. über mehrere Konten)
  List<Transaction> coinTransactions(String coinId) => accounts.where((e) => e.coinId == coinId).fold([], (p, e) => p + e.transactions);

  /// Den Durchschnittspreis für einen Coin ermitteln (ggf. über mehrere Konten!)
  double getCoinsAvgPrice(String coinId) => accounts.where((e) => e.coinId == coinId).fold(0.0, (p, e) => p + e.avgPrice) / accounts.where((e) => e.coinId == coinId).length;
  
  /// Gesamtmenge für einen Coin ermitteln (ggf. über mehrere Konten!)
  double getCoinsTotalAmount(String coinId) => accounts.where((e) => e.coinId == coinId).fold(0.0, (p, e) => p + e.totalAmount);

  /// Gesamtwert für einen Coin ermitteln (ggf. über mehrere Konten)
  double getCoinsTotalValue(String coinId) => accounts.where((e) => e.coinId == coinId).fold(0.0, (p, e) => p + e.totalValue);
  
}