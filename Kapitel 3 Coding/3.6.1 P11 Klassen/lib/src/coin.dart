/**
 * Klasse "Coin" wird benötigt, um Coins aufzulisten, deren Id zu ermitteln oder Marktinformationen zu erhalten
 */
final class Coin {
  final String id; // aus Datenimport über Json
  final String name;
  final String symbol;
  bool? isFavorite; 
  String? imageUrl;
  num? currentPrice;
  int? marketRank;

  Coin(this.id, this.name, this.symbol, [this.isFavorite, this.imageUrl, this.currentPrice, this.marketRank ]);

  factory Coin.fromMap(Map<String, dynamic> c) => Coin(c["id"], c["name"], c["symbol"]);

  bool operator ==(Object other) => other is Coin && this.id == other.id;

  String toString() => "Coin($id, $name, $symbol)";

  void setMarketData(Map<String, dynamic> m) => 
    this ..imageUrl = m["image"] ..currentPrice = m["current_price"] ..marketRank = m["market_cap_rank"]  // wichtige Werte !!!
      ..isFavorite = (this.isFavorite ?? (this.marketRank != null));  // Auf isFovorite setzen (zum Test!) wenn Rang vorhanden...
}

