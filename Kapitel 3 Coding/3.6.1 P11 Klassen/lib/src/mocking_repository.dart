import 'database_repository.dart';
import 'mocking_datas.dart';

class MockingRepository implements DatabaseRepository{
  @override
  Future<Map<String, dynamic>> getUser(String userId) async => mockingUser;
  
  @override
  Future<Map<String, dynamic>> getUserDatas(String userId) async => mockingUserDatas;
 
  @override
  Future<List<dynamic>> getCoins() async => mockingCoins;
  
  @override
  Future<List<dynamic>> getCoinMarketDatas([String currency = 'eur', bool onlyFavorites = false, Set<String> favorites = const {}]) async => mockingCoinDatas;
   
  @override
  Future<List<dynamic>> searchCoins(String query) async => mockingCoins.where((m) => m["id"].contains(query) || m["name"].contains(query)).toList();
  
}