import 'dart:convert';
import 'package:http/http.dart';

import 'account.dart';
import 'coin.dart';
import 'user.dart';
import 'transaction.dart';
import 'commons.dart';

class Data {
    User? user; // Instanz für den angemeldeten User (FireStore Authentification)
    List<Account> accounts = []; // Speichert die Konten für Coins und deren Transaktionen (FireStore)
    List<Coin> coins = []; // Speichert die verfügbaren Coins (aus API)
    Set<String> favorites = {}; // Speichert die favorisierten Coins anhand ihrer ID (String) (FireStore)

    Data(this.user); 
    
    List<Transaction> get transactions => this.accounts.fold([], (p, e) => p + e.transactions);

    Future<bool> getCoinsFromAPI() async {
      List<dynamic> responseList = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/list')));
      responseList.forEach((m) => coins.add(Coin.fromMap(m)));

      return coins.isNotEmpty;
    }

    Future<bool> updateCoinDatas([String? currency = null]) async {
      currency = currency ?? (user == null ? "usd" : user!.currency);

      Set<String> favs = favorites.toSet();
      accounts.forEach((a) => favs.add(a.coinId));
      String favCoins = favs.join(",");

      List<dynamic> responseList = json.decode(await Client().read(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=${currency}&ids=$favCoins')));
      responseList.forEach((e) => coins.firstWhere((c) => c.id == e["id"]).setMarketData(e));

      return responseList.isNotEmpty;
    }
}