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
  List<Transaction> _transactions = [];

  Account(this.userId, this.name, this.coinId); // für Datenbank

  @override
  Iterator get iterator => _transactions.iterator;
  
  get () => _transactions;

  void addTransaction(Transaction transaction) {
    if(transaction.coinId == this.coinId)
      this._transactions.add(transaction);
    else 
      throw(FormatException("Dem Konto für $coinId können keine Transaktionen für ${transaction.coinId} hinzugefügt werden.", this.runtimeType, 18));
  }
  
  void removeTransaction(Transaction transaction) {
    if(transaction.coinId == this.coinId)
      this._transactions.remove(transaction);
    else throw(FormatException("Aus dem Konto für $coinId können keine Transaktionen für ${transaction.coinId} entfernt werden.", this.runtimeType, 25)); 
  }

  String toString() => "Account($userId, $name, $coinId)";
  
}
