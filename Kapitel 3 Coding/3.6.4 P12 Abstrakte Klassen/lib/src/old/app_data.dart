import 'package:test/src/account.dart';

import '../repos/mocking_api_repository.dart';
import '../repos/mocking_repository.dart';

import '../repos/database_repository.dart';
import '../repos/firestore_repository.dart';
import '../repos/api_repository.dart';
import '../repos/coingecko_api_repository.dart';
import 'account_with_transaktions.dart';
import 'user_data.dart';
import '../user.dart';
import '../coin.dart';

const bool isMocking = true; // legt fest, ob reale Daten oder Mockingdaten verwendet werden sollen !!!

DatabaseRepository db = isMocking ? MockingRepository() : FirestoreRepository();  
ApiRepository api = isMocking ? MockingApiRepository() : CoingeckoApiRepository(); 

/// Klasse AppData bildet die Basisdatenklasse für die zu entwickelnde App
/// ----------------------------------------------------------------------
/// - Sie speichert sowohl die (insgesamt verfügbaren) Coins und deren (Markt-)Daten als auch die
/// des User mit seinen benötigten Daten, seinen Konten und deren Transaktionen
/// - Um die Klasse zu veranlassen die Daten der Coins abzurufen wird die Methode "initialize()"
/// benötigt (Aufruf mit "await", da die Daten asynchron aus einer API ermittelt werden!).
class AppData {
  final User user;
  UserData? userData;
  List<Coin> coins = []; // Speichert die verfügbaren Coins (aus API)
  String appCurrency = "eur";

  /// Instanziert die Basis-Datenklasse der App !!!
  /// Dieser enthält sowohl den User selbst als auch deren Daten (Konten, Transaktionen etc.), 
  /// aber auch eine globale Liste der Coins, App-weite Einstellungen etc.
  AppData({required this.user}); 

  Future<void> initialize() async {
    if(user.isIdentified && this.user.id != null ) {
      this.userData = await UserData.fromMap(await db.getUserDatas(this.user.id!));

      // Neue Benutzerdaten anlegen, wenn keine Userdaten zum User existieren
      if(userData == null && this.user.id != null)
        this.userData = UserData(userID: this.user.id!) ..userCurrency = appCurrency; 
    }
    await _getCoinsFromRepository(); 
    await _updateCoinFromRepository(appCurrency, false); 
  }

  // Zum TESTEN !!!
  Future<List<dynamic>> getAccounts() async => await db.getAccounts(user.id!);
  Future<List<dynamic>> getTransactions() async => await db.getTransactions(user.id!, "o5b943uvj8v39849v8er");

  Future<bool> refreshMarketDatas(String currency, bool onlyFavorites) {
    return _updateCoinFromRepository(currency, onlyFavorites); }

  /// Holt eine Liste aller verfügbaren Coins mit deren ID, dem Namen und dessen Symbol
  Future<bool> _getCoinsFromRepository() async {
    List<dynamic> responseList = await api.getCoins();
;
    responseList.forEach((m) => coins.add(Coin.fromMap(m)));

    return responseList.isNotEmpty;
  }

  /// Ermittelt weitere Daten (image, Marktrang, Preis) und ergänzt diese in der Liste der Coins
  Future<bool> _updateCoinFromRepository([String? currency = null, bool onlyFavorites = false]) async {
    currency ??= userData!.userCurrency;

    Set<String> favs = userData!.favorites;
    userData!.accounts.forEach((a) => favs.add(a.coinId));

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
      return getCoin(coinId)!.currentPrice ?? 0.0 - (userData == null ? 0.0 : userData!.getCoinsAvgPrice(coinId)); 
    else 
      return 0.0; }
  
  /// Ermittelt die Preisdifferenz eines Accounts (und dessen Coin)
  double getAccountDifference(String accountId) {
    accountWithTransaktions account = userData!.accounts.singleWhere((a) => a.id == accountId);
    if(getCoin(account.coinId) != null)
      return getCoin(account.coinId)!.currentPrice ?? 0.0 - account.avgPrice;
    else
      return 0.0;
  }
}