import 'dart:convert';
import 'package:http/http.dart';

import 'user_data.dart';
import 'user.dart';
import 'coin.dart';

class AppData {
  final User user;
  UserData? userData;
  List<Coin> coins = []; // Speichert die verfügbaren Coins (aus API)

  AppData({required this.user}) {
    if(user.isIdentified && this.user.id != null ) {
      this.userData = UserData(userID: this.user.id!);
    }
  }

  Future<bool> getCoinsFromAPI() async {
    List<dynamic> responseList = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/list')));
    responseList.forEach((m) => coins.add(Coin.fromMap(m)));

    return coins.isNotEmpty;
  }

  Future<bool> updateCoinDatas([String? currency = null]) async {
    currency ??= userData!.currency;

    Set<String> favs = userData!.favorites;
    userData!.accounts.forEach((a) => favs.add(a.coinId));
    String favCoins = favs.join(",");

    List<dynamic> responseList = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=${currency}&ids=$favCoins')));
    responseList.forEach((e) => coins.firstWhere((c) => c.id == e["id"]).setMarketData(e));

    return responseList.isNotEmpty;
  }

  Set<Coin> getTop100Coins() => coins.where((c) => c.marketRank != null).toSet();
  Set<Coin> getFavoriteCoins(Set<String> favorites) => coins.where((c) => favorites.contains(c.id)).toSet();

}