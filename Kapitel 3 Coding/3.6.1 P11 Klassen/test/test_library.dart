import 'package:http/http.dart';
import 'dart:convert';

import '../lib/coin_library.dart';
// import '../lib/coin_data_model.dart';

void main() {
  // test();
  test2();
}

Future<void> test2() async {
  User user = User("Microwalker");
  user.id = "sdi536i2oih34h6i3h6u3h22hp46236";
  
  AppData aData = AppData(user: user);
  UserData uData = UserData(userID: user.id!);
  print("${aData.user} => isIdentified: ${aData.user.isIdentified}");

  await aData.getCoinsFromAPI();

  uData.favorites.addAll({"bitcoin","ethereum","iota","bonk","doge",r"trump_official"});
  await aData.updateCoinDatas("eur");

  // print(data.coins);
  List<Coin> favCoins = aData.getTop100Coins().toList();
  favCoins.sort((p, e) => p.marketRank! <= e.marketRank! ? -1 : 1);
  favCoins.forEach((e) => print(e));

  // data.coins.where((c) => data.favorites.contains(c.id)).forEach((c) => print("$c => ${c.currentPrice} €"));
}

Future<void> test() async {
  User u = User("Microwalker");
  u.id = "234k2nhuop34b32pb4jn43otu64n"; 
  print(u);

  AppData aData = AppData(user: u);
  UserData uData = UserData(userID: u.id!);

  List<Coin> coins = [Coin("terra_classic","Terra Classic","LUNC"), Coin("uniswap", "Uniswap", "UNI"), Coin("iota","Miota","IOTA"), Coin("shiba_inu","SHIBA INU","SHIB")];
  List<Coin> cg_coins = [];

  List<dynamic> responseList = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/list')));
  responseList.forEach((m) => cg_coins.add(Coin.fromMap(m)));

  String favCoins = ""; 
  cg_coins.forEach((c) => favCoins += uData.isFavoriteCoin(c.id) ? c.id + (cg_coins.last != c ? "," : "") : "");
  print(favCoins);
  
  List<dynamic> responseMap = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&ids=$favCoins')));
  responseMap.forEach((e) => cg_coins.firstWhere((c) => c.id == e["id"]).setMarketData(e));
  
  Account a = Account(u.id!, "Bitcoin 1", "bitcoin");
  print(a);

  List<Account> accounts = [a, Account(u.id!, "Bitcoin 2", "bitcoin"), Account(u.id!, "Shibas", "shiba_inu")];
  print(accounts);

  Transaction t = Transaction("bitcoin", DateTime(2010, 4, 11), 5000, 1234.56, TransactionType.Buy);
  print(t);
  
  accounts.firstWhere((e) => e.coinId == t.coinId).addTransaction(t);
  a.addTransaction(t);
  print(a);
  
  try {
    accounts.firstWhere((e) => e.coinId == "ethereum").addTransaction(Transaction("ethereum", DateTime(2016, 5, 18), 50, 5678.90, TransactionType.Reward));
  } catch(e) { print("Transaktion konnte keinem Konto hinzugefügt werden: $e"); }
  print(a);

  accounts.forEach((t) => t.transactions.forEach((t) => print(t)));    

  print(coins);

  // cg_coins.forEach((c) => print(c));
  print("Insgesamt ${cg_coins.length} Coins geladen!");

  cg_coins.where((c) => uData.isFavoriteCoin(c.id)).forEach((c) => print("${c.name} (Rang:${c.marketRank}): Current Price = ${c.currentPrice} €"));

  Coin c = Coin("bitcoin", "Bitcoin", "BTC");
  print(c);

  coins.add(c);
  
  coins.add(Coin("ethereum", "Ethereum", "ETH"));
  coins.addAll([Coin("atom", "Cosmos Atom", "ATOM"), Coin("solana", "Solana", "SOL")]);
  print(coins);
}