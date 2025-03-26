import 'database_repository.dart';
import 'mocking_datas.dart';
import '../account.dart';
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
  void addAccount(String userId, Account account) => mockingUserDatas["accounts"].add(account);

  // TODO: Methode im interface deklarieren
  void addTransaction(String userId, String accountId, Transaction transaction) {
    mockingUserDatas["accounts"].where((a) => a["account_id"] == accountId)["transactions"].add(transaction);
  }
  
  @override
  List<dynamic> getAccounts(String userId) => mockingUserDatas["accounts"];
  
  @override
  List<dynamic> getTransactions(String userId, String accountId) {
    Map<String, dynamic> account = getAccounts(userId).singleWhere((a) => (a as Map)["account_id"] == accountId);
    return account["transactions"];
  }
}