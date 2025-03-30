final class Settings {
  final String userId;
  final bool hold1year;
  final String userCurrency;
  final List<String> favorites;

  Settings({required this.userId, required this.hold1year, required this.userCurrency, required this.favorites});
  
  factory Settings.fromMap(Map m) => Settings(
    // Map{"user_id": "...", "hold_1year": bool, "user_currency": "...", "favorites": ["...", ...]}
    userId: m["user_id"], 
    hold1year: m["hold_1year"], 
    userCurrency: m["user_currency"], 
    favorites: m["favorites"]);

  @override
  String toString() => "Settings($userId, $hold1year, $userCurrency, $favorites)";
}