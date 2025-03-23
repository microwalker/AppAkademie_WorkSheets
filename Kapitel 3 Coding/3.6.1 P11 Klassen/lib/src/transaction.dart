import 'commons.dart';

/**
 * Klasse "Transaction" zum Erfassen von (u.a.) An- und Verkäufen von Coins
 */
final class Transaction {
  String? id; // für Datenbank
  String coinId;
  String currencyId;
  DateTime date;
  TransactionType type;
  double amount;
  double value; 
  double? fees;
  String? feeCurrencyId;

  Transaction(this.coinId, this.currencyId, this.date, this.amount, this.value, this.type);

  factory Transaction.fromFireStore(Map<String, dynamic> m) => Transaction(m["coinId"], m["currencyId"], m["date"], m["amount"], m["value"], m["type"]) ..id = m["id"] ..setFees(m["fees"], m["feeCurrencyId"]);

  void setFees(double amount, String currencyId) => this ..fees = amount  ..feeCurrencyId = currencyId;

  String toString() => "Transaction($coinId, $date, $amount, $value, $type)";
}
