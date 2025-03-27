import '../lib/coin_library.dart';

void main() {
  test();
}

Future<void> test() async {
  User user = User.fromMap(mockingUser);
  print("\nUser ${user.username} angemeldet...");

  AppData aData =  await AppData(user: user);
  await aData.initialize();
  print("\nCoin-Daten und Userdaten (inkl. Konten und Transaktionen) geladen...");

  print(aData.getAccounts());
  print(aData.getTransactions());

  // Top 100 Coins ausgeben:
  List<Coin> topCoins = await aData.getTop100Coins().toList();
  topCoins.sort((p, e) => p.marketRank! <= e.marketRank! ? -1 : 1);
  print("\nTOP 100 Coins:");
  topCoins.forEach((e) => print(e));

  // Suche: funktioniert!
  List<Coin> results = await aData.searchCoinAPI("bit");
  print("\nSuche nach 'bit':\nErgebnisse:");
  results.forEach((r) => print(r));

  
}
