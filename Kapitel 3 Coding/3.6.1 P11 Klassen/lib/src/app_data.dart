import 'dart:convert';
import 'package:http/http.dart';

import 'account.dart';
import 'user_data.dart';
import 'user.dart';
import 'coin.dart';

class AppData {
  final User user;
  UserData? userData;
  List<Coin> coins = []; // Speichert die verfügbaren Coins (aus API)
  String appCurrency = "eur";

  /// Instanziert die Basis-Datenklasse der App !!!
  /// Dieser enthält sowohl den User selbst als auch deren Daten (Konten, Transaktionen etc.), 
  /// aber auch eine globale Liste der Coins, App-weite Einstellungen etc.
  AppData({required this.user}) {
    if(user.isIdentified && this.user.id != null ) {
      this.userData = UserData(userID: this.user.id!);
    }
  }

  /// Holt eine Liste aller verfügbaren Coins mit deren ID, dem Namen und dessen Symbol
  Future<bool> getCoinsFromAPI() async {
    List<dynamic> responseList = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/list')));
    responseList.forEach((m) => coins.add(Coin.fromMap(m)));

    return coins.isNotEmpty;
  }

  /// Ermittelt weitere Daten (image, Marktrang, Preis) und ergänzt diese in der Liste der Coins
  Future<bool> updateCoinDatas([String? currency = null]) async {
    currency ??= userData!.userCurrency;

    Set<String> favs = userData!.favorites;
    userData!.accounts.forEach((a) => favs.add(a.coinId));
    String favCoins = favs.join(",");

    List<dynamic> responseList = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=${currency}&ids=$favCoins')));
    responseList.forEach((e) => coins.firstWhere((c) => c.id == e["id"]).setMarketData(e));

    return responseList.isNotEmpty;
  }

  /// Sucht nach Coins, die den Suchstring (query) enthalten (über API!)
  Future<List<Coin>> searchCoinAPI(String query) async { 
    List<Coin> erg = [];
    List<dynamic> responseList = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/search?query=$query')))["coins"];
    responseList.forEach((m) => erg.add(Coin.fromMap(m)));
    return erg;
  }

  /// sucht (in der lokalen Liste!) nach Coins, deren Id oder Name den Suchstring (query) enthalten
  List<Coin> searchCoin(String query) => coins.where((c) => c.id.contains(query) || c.name.contains(query)).toList();

  /// Ermittelt anhand dessen ID (als String) einen Coin aus der Liste der verfügbaren Coins
  Coin getCoin(String coinId) => coins.singleWhere((c) => c.id == coinId);

  /// Ermittelt die "Top 100" aller Coins (nach Gesamtmarktwert, unsortiert als Set)
  Set<Coin> getTop100Coins() => coins.where((c) => c.marketRank != null).toSet();

  /// Gibt alle als Favorit gekennzeichneten Coins als (unsortiertes) Set zurück
  Set<Coin> getFavoriteCoins(Set<String> favorites) => coins.where((c) => favorites.contains(c.id)).toSet();
  
  /// Ermittelt die Preisdifferenz eines Coins (ggf. über mehrere Konten hinweg) 
  double getTotalDifference(String coinId) => getCoin(coinId).currentPrice ?? 0.0 - (userData == null ? 0.0 : userData!.getCoinsAvgPrice(coinId));
  
  /// Ermittelt die Preisdifferenz eines Accounts (und dessen Coin)
  double getAccountDifference(String accountId) {
    Account account = userData!.accounts.singleWhere((a) => a.id == accountId);
    return getCoin(account.coinId).currentPrice ?? 0.0 - account.avgPrice;
  }
}