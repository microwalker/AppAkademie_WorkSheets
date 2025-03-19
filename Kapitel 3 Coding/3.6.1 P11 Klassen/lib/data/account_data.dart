import 'transaction_data.dart';

/**
 * Klasse "Account" wird benötigt, um Transaktionen für einen Coin zu sammeln... 
 * wird aber ggf. doch durch eine einfache Liste ersetzt!!! 
 */
class AccountData {
  final String id; // für Datenbank ? ...wird dann ja wahrscheinlich nicht gebraucht!?
  final String userId; // = Kontoinhaber ... wird wohl auch garnicht benötigt!?
  final String name;
  final String coinId; // entspricht der Coin.id aus dem Datenimport
  final List<TransactionData> transactions;

  AccountData({required this.id, required this.userId, required this.name, required this.coinId, required this.transactions});
}
