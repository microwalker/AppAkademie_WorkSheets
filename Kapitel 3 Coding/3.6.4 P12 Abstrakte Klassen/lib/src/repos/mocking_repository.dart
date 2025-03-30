import 'database_repository.dart';
import 'mocking_datas.dart';
import '../fullAccount.dart';
import '../transaction.dart';

class MockingRepository implements DatabaseRepository{

  @override 
  Future<Map<String, dynamic>> getUser(String userId) async => mockingUser;
  
  @override 
  Future<Map<String, dynamic>> getUserDatas(String userId) async => mockingUserDatas;
 
  // TODO: Methode im interface deklarieren
  void updateUserData(String userId, {String curreny = "eur", bool hasToHold1Year = true}) {
    mockingUserDatas
      ..update("currency", (value) => curreny)
      ..update("hold_1year", (value) => hasToHold1Year);
  }

  // TODO: Methode im interface deklarieren
  void addAccount(String userId, FullAccount account) => mockingUserDatas["accounts"].add(account);

  // TODO: Methode im interface deklarieren
  void addTransaction(String userId, String accountId, Transaction transaction) {
    mockingUserDatas["accounts"].where((a) => a["account_id"] == accountId)["transactions"].add(transaction);
  }
  
  @override 
  Future<List<dynamic>> getAccounts(String userId) async => mockingUserDatas["accounts"];
  
  @override 
  Future<List<dynamic>> getTransactions(String userId, String? accountId) async => mockingTransactions["transactions"];
  
  @override
  Future<Map<String, dynamic>> getSettings(String userId) async => mockingSettings;
}