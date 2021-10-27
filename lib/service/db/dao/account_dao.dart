import 'package:money_tractor/service/db/model/account.dart';
import 'package:sqflite/sqflite.dart';

class AccountDao {
  Database _db;
  final String tableName = 'accounts';

  void checkDB(Database database) {
    if (_db == null) _db = database;
  }

  Future<int> insert(Account object) async {
    return await _db.insert(
      tableName,
      object.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Account>> all() async {
    final List<Map<String, dynamic>> maps = await _db.query(tableName);

    return List.generate(maps.length, (i) => Account.fromMap(maps[i]));
  }
}
