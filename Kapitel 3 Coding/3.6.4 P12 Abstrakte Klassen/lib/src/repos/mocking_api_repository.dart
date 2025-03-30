import 'api_repository.dart';
import 'mocking_datas.dart';

class MockingApiRepository implements ApiRepository{
  @override
  /// Gibt eine Liste mit 100 Coins zu Testzecken zurück
  Future<List<dynamic>> getCoinsList() async => mockingCoins;
  
  @override
  /// Gibt eine Liste mit Marktdaten für 100 Coins zurück (zu Testzwecken! Liste muss nicht mit Liste der Coins übereinstimmen !!!)
  Future<List<dynamic>> getCoinMarketDatas([String currency = 'eur', bool onlyFavorites = false, Set<String> favorites = const {}]) async => mockingCoinDatas;
   
  @override
  /// Gibt die Ergebnisse der Suche (innerhalb der 100 Coins der CoinsList !!!) zu Testzwecken zurück
  Future<List<dynamic>> searchCoins(String query) async => mockingCoins.where((m) => m["id"].contains(query) || m["name"].contains(query)).toList();

  @override
  /// Gibt (hier zu Testzwecken) die Chartdaten von 30 Tagen für Shiba-Inu zurück
  Future<List<dynamic>> getCoinChart(String coinId, String currency, int days) async => mockingChartDatas["prices"];
  
  @override
  /// Ermittelt die Preise von Coin(s) in Währung(en), hier zu Testzwecken immer 1234.56 (Egal welcher Coin und welche Währung !!!)
  Future<Map<String, dynamic>> getCoinPrices(List<String> coinIds, List<String> currencyIds) async =>
    { for(String c in coinIds) "$c": { for(String cu in currencyIds) "$cu": 1234.56 }};  // FakeDaten zurückgeben !!!
  
  @override
  /// Liste der akzeptierten Währungen zum Kauf/Verkauf von Kryptos
  Future<List<String>> getCurrencies() async => mockingCurrencyIds;
}