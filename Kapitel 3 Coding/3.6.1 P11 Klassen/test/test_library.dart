import '../lib/coin_library.dart';
import '../lib/data/coin_data.dart';

void main() {
  List<Coin> coins = [Coin("terra_classic","Terra Classic","LUNC"), Coin("uniswap", "Uniswap", "UNI"), Coin("iota","Miota","IOTA"), Coin("shiba_inu","SHIBA INU","SHIB")];

  User u = User("Microwalker");
  u.id = "234k2nhuop34b32pb4jn43otu64n"; 
  print(u);

  Account a = Account(u.id, "Bitcoin 1", "bitcoin");
  print(a);

  List<Account> accounts = [a, Account(u.id, "Bitcoin 2", "bitcoin"), Account(u.id, "Shibas", "shiba_inu")];
  print(accounts);

  Transaction t = Transaction("bitcoin", DateTime(2010, 4, 11), 5000, 1234.56, TransactionType.Buy);
  print(t);
  
  accounts.firstWhere((e) => e.coinId == t.coinId).addTransaction(t);
  a.addTransaction(t);
  print(a);
  
  try {
    accounts.firstWhere((e) => e.coinId == "ethereum").addTransaction(Transaction("ethereum", DateTime(2016, 5, 18), 50, 5678.90, TransactionType.Transfer));
  } catch(e) { print("Transaktion konnte keinem Konto hinzugefügt werden: $e"); }
  print(a);

  accounts.forEach((_a) => _a.transactions.forEach((_t) => print(_t)));    

  print(coins);

  Coin c = Coin("bitcoin", "Bitcoin", "BTC");
  print(c);

  coins.add(c);
  
  coins.add(Coin("ethereum", "Ethereum", "ETH"));
  coins.addAll([Coin("atom", "Cosmos Atom", "ATOM"), Coin("solana", "Solana", "SOL")]);
  print(coins);

  CoinTest ct = CoinTest()
    ..id = "xyz" 
    ..name = "Testcoin"
    ..symbol = "TST";
  print(ct);

  int i = 12;
  i
  ..toString();

}

class CoinTest {
  String? id;
  String? name;
  String? symbol;

  String toString() => "CoinTest: $id - $name ($symbol)";
}