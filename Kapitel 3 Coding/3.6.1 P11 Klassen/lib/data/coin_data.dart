/**
 * Klasse "Coin" wird benötigt, um Coins aufzulisten, deren Id zu ermitteln oder Marktinformationen zu erhalten
 * 
 * ID, Name und Symbol kommen aus API-Call "CoinList", die restlichen Werte aus einer separaten API-Abfrage!
 */
class CoinData {
  final String id; 
  final String name;
  final String symbol;
  final String? imageUrl;
  final double? currentPrice;
  final int? marketRank;

  CoinData({required this.id, required this.name, required this.symbol, this.imageUrl = null, this.currentPrice = null, this.marketRank = null});
}

