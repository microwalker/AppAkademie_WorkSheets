import 'transaction.dart';
import 'commons.dart';

/**
 * Klasse "Account" wird benötigt, um Transaktionen für einen Coin zu sammeln... 
 * wird aber ggf. doch durch eine einfache Liste ersetzt!?!?
 */
class FullAccount {
  String? id; // KontoID für FireStore-Datenbank
  final String userId; // = Kontoinhaber
  final String name;
  final String coinId; // entspricht der Coin.id aus dem Datenimport
  final String accountCurrency;
  List<Transaction> transactions = [];

  @override
  String toString() => "FullAccount($id, $userId, $name, $coinId, $accountCurrency, $transactions)";

  double get avgPrice => transactions.fold(0.0, (p, e) => p + (e.amount / e.value) * commons.polarityOfTransactionType(e.type)) / transactions.length;
  double get totalAmount => transactions.fold(0.0, (p, e) => p + e.amount * commons.polarityOfTransactionType(e.type));
  double get totalValue => transactions.fold(0.0, (p, e) => p + e.value * commons.polarityOfTransactionType(e.type));

  FullAccount(this.id, {required this.userId, required this.name, required this.coinId, required this.accountCurrency, this.transactions = const []}); // für Datenbank

  factory FullAccount.fromMap(Map<String, dynamic> m) => 
    FullAccount(m["id"], 
      userId: m["user_id"], 
      name: m["name"], 
      coinId: m["coin_id"], 
      accountCurrency: m["currency"], 
      transactions: [for(Map<String, dynamic> t in m["transactions"]) Transaction.fromMap(t)]); 

  Map<String, dynamic> toMap() => {
      if(id != null) "id": id,
      "user_id": userId,
      "name": name,
      "coin_id": coinId,
      "currency_id": accountCurrency,
      "transactions": [ for(Transaction t in transactions) t.toMap() ]};

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
