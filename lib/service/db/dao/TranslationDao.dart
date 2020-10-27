import 'package:money_tractor/service/db/model/Translation.dart';
import 'package:sqflite/sqflite.dart';

class TranslationDao {
  Database _db;
  final String tableName = 'translations';

  void checkDB(Database database) {
    if (_db == null) _db = database;
  }

  Future<List<Translation>> all() async {
    final List<Map<String, dynamic>> maps = await _db.query(tableName);

    return List.generate(maps.length, (i) => Translation.fromMap(maps[i]));
  }

  Future<int> insert(Translation translation) async {
    return await _db.insert(
      tableName,
      translation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Translation> getById(int id) async {
    final maps = await _db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return Translation.fromMap(maps.first);
  }

  Future<int> update(Translation translation) async {
    return await _db.update(
      tableName,
      translation.toMap(),
      where: "id = ?",
      whereArgs: [translation.id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
