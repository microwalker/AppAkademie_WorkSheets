abstract class DatabaseRepository {
  Future<Map<String, dynamic>> getUser(String userId);
  Future<Map<String, dynamic>> getUserDatas(String userId);
  
  Future<List<dynamic>> getCoins();
  Future<List<dynamic>> getCoinMarketDatas([String currency = 'eur', bool onlyFavorites = false, Set<String> favorites = const {}]);
  Future<List<dynamic>> searchCoins(String query);
}
