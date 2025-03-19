/**
 * Enumeration für die Transaktionsarten
 * In der geplanten App werden (vorerst!) nur Buy, Sell und ggf. Swaps berücksichtigt!
 */
enum TransactionType { Buy, Sell, In, Out, Swap, Transfer, Staking, Reward, Gift }

/**
 * Klasse "Transaction" zum Erfassen von (u.a.) An- und Verkäufen von Coins
 * 
 * Diese Klasse wird für die Auflistung der Transaktionen von der Klasse "Account" benötigt
 */
final class TransactionData {
  final String id; // für Datenbank ...wird wohl auch nicht benötigt!?
  final String coinId;
  final DateTime date;
  final TransactionType type;
  final double amount;
  final double value; 
  final double? fees;
  final String? feeCurrencyId;

  TransactionData({required this.id, required this.coinId, required this.date, required this.amount, required this.value, required this.type, this.fees, this.feeCurrencyId});
}
