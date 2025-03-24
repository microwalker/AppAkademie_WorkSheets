import 'database_repository.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ApiRepository implements DatabaseRepository {
  /// Holt eine Liste aller verfügbaren Coins mit deren ID, dem Namen und dessen Symbol
  @override
  Future<List<dynamic>> getCoins() async => await json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/list')));
  // Future<List<dynamic>> getCoins() async => json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/list')));

  /// Ermittelt weitere Daten (image, Marktrang, Preis) und ergänzt diese in der Liste der Coins
  @override
  Future<List<dynamic>> getCoinMarketDatas([String currency = 'eur', bool onlyFavorites = false, Set<String> favorites = const {}]) async {
    String favCoins = favorites.join(",");
    return await json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=${currency}${onlyFavorites && favCoins != ""?"&ids=$favCoins":""}')));
  }

  /// Sucht nach Coins, die den Suchstring (query) enthalten (über API!)
  @override
  Future<List<dynamic>> searchCoins(String query) async => await json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/search?query=$query')))["coins"];
  
  @override
  Future<Map<String, dynamic>> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  
  @override
  Future<Map<String, dynamic>> getUserDatas(String userId) {
    // TODO: implement getUserDatas
    throw UnimplementedError();
  }

}