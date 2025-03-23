import 'transaction.dart';
import 'commons.dart';

/**
 * Klasse "Account" wird benötigt, um Transaktionen für einen Coin zu sammeln... 
 * wird aber ggf. doch durch eine einfache Liste ersetzt!?!?
 */
class Account {
  String? id; // KontoID für FireStore-Datenbank
  final String userId; // = Kontoinhaber
  final String name;
  final String coinId; // entspricht der Coin.id aus dem Datenimport
  final String accountCurrency;
  List<Transaction> transactions = [];

  double get avgPrice => transactions.fold(0.0, (p, e) => p + (e.amount / e.value) * commons.polarityOfTransactionType(e.type)) / transactions.length;
  double get totalAmount => transactions.fold(0.0, (p, e) => p + e.amount * commons.polarityOfTransactionType(e.type));
  double get totalValue => transactions.fold(0.0, (p, e) => p + e.value * commons.polarityOfTransactionType(e.type));

  Account(this.userId, this.name, this.coinId, this.accountCurrency); // für Datenbank

  void addTransaction(Transaction transaction) {
    if(transaction.coinId == this.coinId)
      this.transactions.add(transaction);
    else 
      throw(FormatException("Dem Konto für $coinId können keine Transaktionen für ${transaction.coinId} hinzugefügt werden.", this.runtimeType, 23));
  }
  
  void removeTransaction(Transaction transaction) {
    if(transaction.coinId == this.coinId)
      this.transactions.remove(transaction);
    else throw(FormatException("Aus dem Konto für $coinId können keine Transaktionen für ${transaction.coinId} entfernt werden.", this.runtimeType, 30)); 
  }
}
