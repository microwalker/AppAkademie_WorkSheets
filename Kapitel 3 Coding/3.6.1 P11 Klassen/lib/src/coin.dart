/**
 * Klasse "Coin" wird benötigt, um Coins aufzulisten, deren Id zu ermitteln oder Marktinformationen zu erhalten
 */
final class Coin {
  String id; // aus Datenimport
  String name;
  String symbol;
  String? imageUrl;
  double? currentPrice;
  int? marketRank;

  Coin(this.id, this.name, this.symbol, [this.imageUrl = null, this.currentPrice = null, this.marketRank = null]);

  bool operator ==(Object other) => other is Coin && this.id == other.id;

  String toString() => "Coin($id, $name, $symbol)";
}

