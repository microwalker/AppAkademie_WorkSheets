/**
 * Enumeration für die Transaktionsarten
 * In der geplanten App werden (vorerst!) nur Buy, Sell und ggf. Swaps berücksichtigt!
 */
enum TransactionType { Buy, Sell, In, Out, Swap, Transfer, Staking, Reward, Gift }

/**
 * Klasse "Transaction" zum Erfassen von (u.a.) An- und Verkäufen von Coins
 */
final class Transaction {
  String? id; // für Datenbank
  String coinId;
  DateTime date;
  TransactionType type;
  double amount;
  double value; 
  double? fees;
  String? feeCurrencyId;

  Transaction(this.coinId, this.date, this.amount, this.value, this.type);

  String toString() => "Transaction($coinId, $date, $amount, $value, $type)";
}
