abstract interface class DatabaseRepository {
  Future<Map<String, dynamic>> getUser(String userId);
  Future<Map<String, dynamic>> getUserDatas(String userId);

  List<dynamic> getAccounts(String userId);
  List<dynamic> getTransactions(String userId, String accountID);
}
