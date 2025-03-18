import 'dart:async';

import '../lib/coin_library.dart';

void main() {
  User u = User("Microwalker");
  u.id = "234k2nhuop34b32pb4jn43otu64n"; 
  print(u);

  Account a = Account(u.id, "Bitcoin 1", "bitcoin");
  print(a);
  
  Transaction t = Transaction("bitcoin", DateTime(2010, 4, 11), 5000, 1234.56, TransactionType.Buy);
  print(t);
  
  a.transactions.add(t);
  print(a);
  
  List<Coin> coins = [];
  print(coins);

  Coin c = Coin("bitcoin", "Bitcoin", "BTC");
  print(c);

  coins.add(c);
  print(coins);
}