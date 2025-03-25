import 'database_repository.dart';
import 'mocking_datas.dart';

class MockingRepository implements DatabaseRepository{
  @override
  Future<Map<String, dynamic>> getUser(String userId) async => mockingUser;
  
  @override
  Future<Map<String, dynamic>> getUserDatas(String userId) async => mockingUserDatas;
 
  
}