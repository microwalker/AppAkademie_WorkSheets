import 'api_repository.dart';
import 'mocking_datas.dart';

class MockingApiRepository implements ApiRepository{
    @override
  Future<List<dynamic>> getCoins() async => mockingCoins;
  
  @override
  Future<List<dynamic>> getCoinMarketDatas([String currency = 'eur', bool onlyFavorites = false, Set<String> favorites = const {}]) async => mockingCoinDatas;
   
  @override
  Future<List<dynamic>> searchCoins(String query) async => mockingCoins.where((m) => m["id"].contains(query) || m["name"].contains(query)).toList();

}