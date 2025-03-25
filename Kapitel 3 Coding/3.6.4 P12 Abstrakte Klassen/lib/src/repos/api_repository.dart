abstract interface class ApiRepository {
  Future<List<dynamic>> getCoins();
  Future<List<dynamic>> getCoinMarketDatas([String currency = 'eur', bool onlyFavorites = false, Set<String> favorites = const {}]);
  Future<List<dynamic>> searchCoins(String query);
  Future<List<dynamic>> getCoinChart(String coinId, String currency, int days);
}