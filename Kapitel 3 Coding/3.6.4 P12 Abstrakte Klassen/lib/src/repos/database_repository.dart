abstract interface class DatabaseRepository {
  Future<Map<String, dynamic>> getUser(String userId);
  Future<Map<String, dynamic>> getUserDatas(String userId);
  Future<Map<String, dynamic>> getSettings(String userId);
  Future<List<dynamic>> getAccounts(String userId);
  Future<List<dynamic>> getTransactions(String userId, String? accountID);
}
