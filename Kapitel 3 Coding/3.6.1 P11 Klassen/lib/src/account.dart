import 'transaction.dart';

/**
 * Klasse "Account" wird benötigt, um Transaktionen für einen Coin zu sammeln... 
 * wird aber ggf. doch durch eine einfache Liste ersetzt!!! 
 */
final class Account extends Iterable {
  String? id; // für Datenbank
  String userId; // = Kontoinhaber
  String name;
  String coinId; // entspricht der Coin.id aus dem Datenimport
  List<Transaction> transactions = [];

  Account(this.userId, this.name, this.coinId); // für Datenbank

  @override
  Iterator get iterator => this.transactions.iterator;
  
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

  String toString() => "Account($userId, $name, $coinId)";
  
}
