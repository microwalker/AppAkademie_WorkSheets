abstract interface class ApiRepository {
  Future<List<dynamic>> getCoinsList();
  Future<List<dynamic>> getCoinMarketDatas([String currency = 'eur', bool onlyFavorites = false, Set<String> favorites = const {}]);
  Future<List<dynamic>> searchCoins(String query);
  Future<Map<String, dynamic>> getCoinPrices(List<String> coinIds, List<String> currencyIds);
  Future<List<dynamic>> getCoinChart(String coinId, String currency, int days);
  Future<List<String>> getCurrencies();
}