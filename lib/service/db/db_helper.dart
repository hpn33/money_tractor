import 'package:hooks_riverpod/all.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dao/TranslationDao.dart';
import 'dao/objectiveDao.dart';

final dbProvider = Provider.autoDispose((ref) => DatabaseHelper());

class DatabaseHelper {
  final _databaseName = "moneyTractor.db";
  final _databaseVersion = 1;

  Database _database;
  // DatabaseHelper() {
  //   _initDatabase();
  // }

  Future<DatabaseHelper> init() async {
    if (_database != null) return this;

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, v) {
        // db.execute("""CREATE TABLE accounts(
        //       id INTEGER PRIMARY KEY,
        //       title TEXT,
        //       create_at INTEGER,
        //       update_at INTEGER
        //       )
        //       """);

        db.execute("""CREATE TABLE objectives(
              id INTEGER PRIMARY KEY,""" +
            // account_id INTEGER NOT NULL,
            """
              title TEXT,
              create_at INTEGER,
              update_at INTEGER
              )
              """);

        db.execute("""CREATE TABLE translations(
              id INTEGER PRIMARY KEY,""" +
            // account_id INTEGER NOT NULL,
            """
              objective_id INTEGER,
              amoung INTEGER,
              type INTEGER,
              active INTEGER,
              create_at INTEGER,
              update_at INTEGER
              )
              """);
      },
    );

    return this;
  }

  // AccountDao _account = AccountDao();
  ObjectiveDao _objective = ObjectiveDao();
  TranslationDao _translation = TranslationDao();

  // AccountDao get account {
  //   _account.checkDB(_database);

  //   return _account;
  // }

  ObjectiveDao get objective {
    _objective.checkDB(_database);

    return _objective;
  }

  TranslationDao get translation {
    _translation.checkDB(_database);

    return _translation;
  }
}
