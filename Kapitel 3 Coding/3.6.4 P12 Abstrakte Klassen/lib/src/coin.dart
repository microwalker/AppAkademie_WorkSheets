/**
 * Klasse "Coin" wird benötigt, um Coins aufzulisten, deren Id zu ermitteln oder Marktinformationen zu erhalten
 */
class Coin {
  final String id; // aus Datenimport über Json
  final String name;
  final String symbol;
  String? imageUrl;
  double? currentPrice;
  int? marketRank;

  Coin(this.id, this.name, this.symbol, [this.imageUrl, this.currentPrice, this.marketRank ]);

  factory Coin.fromMap(Map<String, dynamic> c) => Coin(c["id"], c["name"], c["symbol"]);

  bool operator ==(Object other) => other is Coin && this.id == other.id;

  void setMarketData(Map<String, dynamic> m) {
    imageUrl = m["image"];
    currentPrice = (m["current_price"] as num).toDouble();
    marketRank = m["market_cap_rank"];
  }

  String toString() => "Coin($id, $name, $symbol, $marketRank)";
  
  Map<String, dynamic> toMap() => {"id":id, "name":name, "symbol":symbol}; 

  /// Methode dient lediglich dem Export von Testdaten!!!
  Map<String, dynamic> datasToMap() => {"id":id,"current_price":currentPrice,"market_cap_rank":marketRank};
}

