import 'api_repository.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CoingeckoApiRepository implements ApiRepository {
  /// Holt eine Liste aller verfügbaren Coins mit deren ID, dem Namen und dessen Symbol
  @override
  Future<List<dynamic>> getCoins() async => await json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/list')));
  
  /// Ermittelt weitere Daten (image, Marktrang, Preis) und ergänzt diese in der Liste der Coins
  @override
  Future<List<dynamic>> getCoinMarketDatas([String currency = 'eur', bool onlyFavorites = false, Set<String> favorites = const {}]) async =>
    json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=${currency}${onlyFavorites && favorites == {} ?"&ids=${favorites.join(",")}":""}')));

  /// Sucht nach Coins, die den Suchstring (query) enthalten (über API!)
  @override
  Future<List<dynamic>> searchCoins(String query) async => 
    json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/search?query=$query')))["coins"];

  /// Ermittelt die Chartdaten eines Coins (), Rückgabe pro Wert: [<UNIX TimeStamp>, <Currency Value>]. Zeit-Granulierung efolgt automatisch!
  @override
  Future<List<dynamic>> getCoinChart(String coinId, String currency, int days) async =>
    json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=$currency&days=$days')));
}