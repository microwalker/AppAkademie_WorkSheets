abstract class DatabaseRepository {
  Future<Map<String, dynamic>> getUser(String userId);
  Future<Map<String, dynamic>> getUserDatas(String userId);

}
