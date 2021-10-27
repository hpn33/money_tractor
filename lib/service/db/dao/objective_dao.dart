import 'package:money_tractor/service/db/model/objective.dart';
import 'package:sqflite/sqflite.dart';

class ObjectiveDao {
  Database _db;
  final String tableName = 'objectives';

  void checkDB(Database database) {
    if (_db == null) _db = database;
  }

  Future<int> insert(Objective object) async {
    return await _db.insert(
      tableName,
      object.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Objective>> all() async {
    final List<Map<String, dynamic>> maps = await _db.query(tableName);

    return List.generate(maps.length, (i) => Objective.fromMap(maps[i]));
  }

  Future<void> update(Objective objective) async {
    await _db.update(
      tableName,
      objective.toMap(),
      where: "id = ?",
      whereArgs: [objective.id],
    );
  }

  Future<void> delete(int id) async {
    await _db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<Objective> getById(int id) async {
    final maps = await _db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return Objective.fromMap(maps.first);
  }
}
