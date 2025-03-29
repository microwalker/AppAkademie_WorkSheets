import 'commons.dart';

/**
 * Klasse "Transaction" zum Erfassen von (u.a.) An- und Verkäufen von Coins
 */
final class Transaction {
  final String? id; // für Datenbank
  final String coinId;
  final String accountId;
  final String currencyId;
  final DateTime date;
  final TransactionType type;
  final double amount;
  final double value; 
  final double? fees;
  final String? feeCurrencyId;

  Transaction({required this.id, required this.coinId, required this.accountId, required this.currencyId, required this.date, required this.type, required this.amount, required this.value, required this.fees, required this.feeCurrencyId});

  factory Transaction.fromMap(Map<String, dynamic> m) => Transaction(
    id: m["id"], 
    coinId: m["coin_id"], 
    accountId: m["account_id"], 
    currencyId: m["currency_id"], 
    date: m["date"], type: m["type"], 
    amount: m["amount"], 
    value:  m["value"], 
    fees: m["fees"], 
    feeCurrencyId: m["fee_currency_id"]);
 
  String toString() => "Transaction($coinId, $date, $amount, $value, $type)";
}
