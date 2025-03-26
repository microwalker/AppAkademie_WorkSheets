import 'database_repository.dart';

class FirestoreRepository implements DatabaseRepository {
  @override
  Future<Map<String, dynamic>> getUser(String userId) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getUserDatas(String userId) {
    // TODO: implement getUserDatas
    throw UnimplementedError();
  }
  
  @override
  List getAccounts(String userId) {
    // TODO: implement getAccounts
    throw UnimplementedError();
  }
  
  @override
  List getTransactions(String userId, String accountID) {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

}