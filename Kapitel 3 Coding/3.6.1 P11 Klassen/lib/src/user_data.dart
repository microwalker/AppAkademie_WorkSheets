import 'account.dart';
import 'transaction.dart';
class UserData {
  String userID; // Instanz für den angemeldeten User (FireStore Authentification)
  List<Account> accounts = []; // Speichert die Konten für Coins und deren Transaktionen (FireStore)
  Set<String> favorites = {}; // Speichert die favorisierten Coins anhand ihrer ID (String) (FireStore)
  String currency = "eur";

  UserData({required this.userID});

  // TODO: Favoriten aus FireStore holen
  // TODO: Accounts aus FireStore holen 
  // TODO: Currency (oder mehrere???) aus FireStore holen
  
  /// Prüft, ob ein Coin als Favorit gespeichert wurde
  bool isFavoriteCoin(String coinID) => favorites.contains(coinID);

  /// Alle Transaktionen (über alle Konten hinweg) als Liste zurückgeben
  List<Transaction> allTransactions() => this.accounts.fold([], (p, e) => p + e.transactions);

  /// Alle Transaktionen für einen Coinzurückgeben (ggf. über mehrere Konten)
  List<Transaction> coinTransactions(String coinID) => accounts.where((e) => e.coinId == coinID).fold([], (p, e) => p + e.transactions);

  /// Den Durchschnittspreis für einen Coin ermitteln (ggf. über mehrere Konten!)
  double getAccountAvgPrice(String coinID) => accounts.where((e) => e.coinId == coinID).fold(0.0, (p, e) => p + e.avgPrice) / accounts.where((e) => e.coinId == coinID).length;

  /// Gesamtmenge für einen Coin ermitteln (ggf. über mehrere Konten!)
  double getAccountTotalAmount(String coinID) => accounts.where((e) => e.coinId == coinID).fold(0.0, (p, e) => p + e.totalAmount);

  /// Gesamtwert für einen Coin ermitteln (ggf. über mehrere Konten)
  double getAccountTotalValue(String coinID) => accounts.where((e) => e.coinId == coinID).fold(0.0, (p, e) => p + e.totalValue);
}