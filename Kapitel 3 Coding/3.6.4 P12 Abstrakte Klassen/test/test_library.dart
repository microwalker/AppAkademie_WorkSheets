import '../lib/coin_library.dart';

void main() {
  testWithMyCoinsData();
  // testWithGranulatedData();
}

void testWithMyCoinsData() async {
  User user = User.fromMap(mockingUser);
    print("\nUser ${user.username} angemeldet...");

  MyCoinsData mcd = MyCoinsData(user: user);
  await mcd.initialize();

  print(mcd);

  mcd.coins.where((c) => c.currentPrice != null).forEach((e) => print(e));
}

void testWithGranulatedData() async {
  User user = User.fromMap(mockingUser);
    print("\nUser ${user.username} angemeldet...");

  MyApp myApp = MyApp();

  await myApp.initialize();
  print("\nCoin-Daten und Userdaten (inkl. Konten und Transaktionen) geladen...");

  print(myApp.settings);
  print(myApp.accounts);
  print(myApp.transactions);

  // Top 100 Coins ausgeben:
  List<Coin> topCoins = await myApp.getTop100Coins().toList();
  topCoins.sort((p, e) => p.marketRank! <= e.marketRank! ? -1 : 1);
  print("\nTOP 100 Coins:");
  topCoins.forEach((e) => print(e));

  // Suche: funktioniert!
  List<Coin> results = await myApp.searchCoinAPI("bit");
  print("\nSuche nach 'bit':\nErgebnisse:");
  results.forEach((r) => print(r));
 
}
class MyApp {
  DatabaseRepository db = MockingRepository();
  ApiRepository api = MockingApiRepository();

  User? user;
  List<Coin> coins = [];
  Settings? settings;
  List<Account> accounts = [];
  List<Transaction> transactions = [];

  MyApp();

  Future<void> initialize() async {
    user = User.fromMap(await db.getUser(""));
    settings = Settings.fromMap(await db.getSettings(""));
    
    (await db.getAccounts(user!.id!)).forEach((a) => accounts.add(Account.fromMap(user!.id!, a)));
    (await db.getTransactions(user!.id!, null)).forEach((t) => transactions.add(Transaction.fromMap(t)));

    await getCoinsFromRepository();
    await updateCoinFromRepository();    
  }

  Future<List<dynamic>> getAccounts() async => await db.getAccounts(user!.id!);
  Future<List<dynamic>> getTransactions() async => await db.getTransactions(user!.id!, "o5b943uvj8v39849v8er");

  Future<bool> refreshMarketDatas(String currency, bool onlyFavorites) {
    return updateCoinFromRepository(currency, onlyFavorites); }

  /// Holt eine Liste aller verfügbaren Coins mit deren ID, dem Namen und dessen Symbol
  Future<bool> getCoinsFromRepository() async {
    List<dynamic> responseList = await api.getCoinsList();
;
    responseList.forEach((m) => coins.add(Coin.fromMap(m)));

    return responseList.isNotEmpty;
  }

  /// Ermittelt weitere Daten (image, Marktrang, Preis) und ergänzt diese in der Liste der Coins
  Future<bool> updateCoinFromRepository([String? currency = null, bool onlyFavorites = false]) async {
    currency ??= settings!.userCurrency;

    Set<String> favs = settings!.favorites.toSet();
    accounts!.forEach((a) => favs.add(a.coinId));

    List<dynamic> responseList = await api.getCoinMarketDatas(currency, onlyFavorites, favs);
    responseList.forEach((e) { 
      if(getCoin(e["id"]) != null) 
        getCoin(e["id"])!.setMarketData(e);
    });

    return responseList.isNotEmpty;
  }

  /// Sucht nach Coins, die den Suchstring (query) enthalten
  Future<List<Coin>> searchCoinAPI(String query) async { 
    List<Coin> foundCoins = [];
    
    List<dynamic> responseList = await api.searchCoins(query); 
    responseList.forEach((m) => foundCoins.add(Coin.fromMap(m)));
    
    return foundCoins;
  }

  /// sucht (in der lokalen Liste!) nach Coins, deren Id oder Name den Suchstring (query) enthalten
  List<Coin> searchCoin(String query) => coins.where((c) => c.id.contains(query) || c.name.contains(query)).toList();

  /// Ermittelt anhand dessen ID (als String) einen Coin aus der Liste der verfügbaren Coins
  Coin? getCoin(String coinId) {
    try {
      return coins.singleWhere((c) => c.id == coinId);
    } catch(e) {
      return null;
    }
  }

  /// Ermittelt die "Top 100" aller Coins (nach Gesamtmarktwert, unsortiert als Set)
  Set<Coin> getTop100Coins() => coins.where((c) => c.marketRank != null && c.marketRank! <= 100).toSet();
  // Set<Coin> getTop100Coins() {
  //   List<Coin> erg = coins.where((c) => c.marketRank != null && c.marketRank! <= 100).toList();
  //   return erg.toSet();
  // }

  /// Gibt alle als Favorit gekennzeichneten Coins als (unsortiertes) Set zurück
  Set<Coin> getFavoriteCoins(Set<String> favorites) => coins.where((c) => favorites.contains(c.id)).toSet();
  
  /// Ermittelt die Preisdifferenz eines Coins (ggf. über mehrere Konten hinweg) 
  double getTotalDifference(String coinId) { 
    if(getCoin(coinId) != null) 
      return getCoin(coinId)!.currentPrice ?? 0.0 - transactions!.where((t) => t.coinId == coinId).fold(0.0, (p, e) => (p + e.value)/2); 
    else 
      return 0.0; }
  
  /// Ermittelt die Preisdifferenz eines Accounts (und dessen Coin)
  double getAccountDifference(String accountId) {
    Account account = accounts!.singleWhere((a) => a.id == accountId);
    if(getCoin(account.coinId) != null)
      return getCoin(account.coinId)!.currentPrice ?? 0.0 - transactions!.where((t) => t.accountId == accountId).fold(0.0, (p, e) => (p + e.value)/2); 
    else
      return 0.0;
  }

}