import 'commons.dart';

/**
 * Klasse "Transaction" zum Erfassen von (u.a.) An- und Verkäufen von Coins
 */
final class Transaction {
  String? id; // für Datenbank
  String coinId;
  String accountId;
  String currencyId;
  DateTime date;
  TransactionType type;
  double amount;
  double value; 
  double? fees;
  String? feeCurrencyId;

  Transaction(this.coinId, this.accountId, this.currencyId, this.date, this.amount, this.value, this.type);

  factory Transaction.fromMap(Map<String, dynamic> m) => 
    Transaction(m["coin_id"], m["account_id"], m["currency_id"], m["date"], m["amount"], m["value"], m["type"]) ..id = m["id"] ..setFees(m["fees"], m["fee_currency_id"]);

  void setFees(double amount, String currencyId) => this ..fees = amount  ..feeCurrencyId = currencyId;

  String toString() => "Transaction($coinId, $date, $amount, $value, $type)";
}
