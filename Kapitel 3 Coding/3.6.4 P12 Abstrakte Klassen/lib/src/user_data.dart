import 'fullAccount.dart';
import 'transaction.dart';

class UserData {
  String userID; // Instanz für den angemeldeten User (FireStore Authentification)
  List<FullAccount> accounts = []; // Speichert die Konten für Coins und deren Transaktionen (FireStore)
  Set<String> favorites = {}; // Speichert die favorisierten Coins anhand ihrer ID (String) (FireStore)
  String userCurrency = "eur";
  bool hasToHold1Year = true;

  UserData({required this.userID});

  @override
  String toString() => "UserData($userID, $accounts, $favorites, $userCurrency, $hasToHold1Year)";

  factory UserData.fromMap(Map<String, dynamic> m) => UserData(userID: m["user_id"]) 
    ..userCurrency = m["currency"]
    ..hasToHold1Year = m["hold_1year"]
    ..favorites = { for(String s in m["favorites"]) s }
    ..accounts = [ for(Map<String, dynamic> a in m["accounts"]) FullAccount.fromMap(a) ];

  Map<String, dynamic> toMap() => {
    "user_id": userID,
    "currency": userCurrency,
    "hold_1year": hasToHold1Year,
    "favorites": [ favorites.toList() ],
    "accounts": [ for(FullAccount a in accounts) a.toMap() ]
  };
 
  void addAccount(String name, String coinID, [String currency = "eur"]) {
     FullAccount account =  FullAccount(null, userId: this.userID, name: name, coinId: coinID, accountCurrency: currency);
     // Speichern und ID ermitteln ...
     account.id = account.hashCode.toString(); // TODO: name durch FireStore-ID ersetzen
     accounts.add(account);
  }

  void removeAccount(String accountId) {
    FullAccount account = accounts.singleWhere((a) => a.id == accountId);
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