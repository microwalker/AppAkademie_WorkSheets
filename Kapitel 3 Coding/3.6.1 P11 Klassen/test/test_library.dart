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
  aData.userData = await UserData(userID: user.id!);
  // print("${aData.user} => isIdentified: ${aData.user.isIdentified}");

  await aData.getCoinsFromRepository();

  aData.userData!.favorites.addAll({"bitcoin","ethereum","iota","bonk","doge","trump-official","shiba-inu"});
  await aData.updateCoinFromRepository("eur");

  // print("Top 100: ${await aData.getTop100Coins()}");

  // print(data.coins);
  List<Coin> topCoins = await aData.getTop100Coins().toList();
  topCoins.sort((p, e) => p.marketRank! <= e.marketRank! ? -1 : 1);
  topCoins.forEach((e) => print(e));

  // print("JSON-Encoded:");
  // List<Map<String, dynamic>> coinMap = [];
  // topCoins.forEach((c) => coinMap.add(c.toMap()));
  // print(coinMap);

  print("Marktdaten:");
  List<dynamic> cData = [];
  topCoins.forEach((c) => cData.add(c.datasToMap()));
  print(cData);

  // List<Coin> favCoins = await aData.getFavoriteCoins(aData.userData!.favorites).toList();
  // print(favCoins); 

  // // Suche: funktioniert!
  // List<Coin> results = await aData.searchCoinAPI("bit");
  // print("Suche nach 'bit' => $results");

  // aData.userData!.addAccount("Bitcoin 1", "bitcoin");
  // aData.userData!.accounts.singleWhere((a) => a.id == "Bitcoin 1").addTransaction(Transaction("bitcoin", "eur", DateTime.now(), 0.5, 37826.44, TransactionType.Buy));

  // print(aData);

  // data.coins.where((c) => data.favorites.contains(c.id)).forEach((c) => print("$c => ${c.currentPrice} €"));

  DatabaseRepository db = MockingRepository();
  AppData appData = AppData(user: User.fromMap(await db.getUser("")));
  
  Map<String, dynamic> userData = await db.getUserDatas("");
  print(userData); // Ausgabe als iterables Map-Objekt
  print(json.encode(userData)); // kodierte Ausgabe (Speicherformat)
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
  
  Account a = Account(u.id!, "Bitcoin 1", "bitcoin", "eur");
  print(a);

  List<Account> accounts = [a, Account(u.id!, "Bitcoin 2", "bitcoin", "eur"), Account(u.id!, "Shibas", "shiba_inu", "eur")];
  print(accounts);

  Transaction t = Transaction("bitcoin", "eur", DateTime(2010, 4, 11), 5000, 1234.56, TransactionType.Buy);
  print(t);
  
  accounts.firstWhere((e) => e.coinId == t.coinId).addTransaction(t);
  a.addTransaction(t);
  print(a);
  
  try {
    accounts.firstWhere((e) => e.coinId == "ethereum").addTransaction(Transaction("ethereum", "eur", DateTime(2016, 5, 18), 50, 5678.90, TransactionType.Reward));
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