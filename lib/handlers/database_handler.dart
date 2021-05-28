import 'dart:io';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/models/savable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  static Database _database;

  Future<Database> openConnection() async {
    if (_database == null) {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path + Constant.dbName;
      _database = await openDatabase(path,
          version: 1, onCreate: _createDb, onUpgrade: _upgradeDb);
    }
    return _database;
  }

  void _createDb(Database db, int version) async {
    List<String> partsSqlList = Part.getOnCreateSqlList();

    for (String sql in partsSqlList) {
      await db.execute(sql);
    }
  }

  void _upgradeDb(Database db, int oldVersion, int newVersion) async {}

  Future closeConnection() async => _database.close();

  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    assert(_database != null, 'DB connection should be initialized');

    return await _database.query(tableName);
  }

  Future<int> insert(Savable savable) async {
    return await _database.insert(savable.getTableName(), savable.toMap());
  }

  void insertAll(List<Savable> savables) async {
    Batch batch = _database.batch();
    for (Savable savable in savables) {
      batch.insert(savable.getTableName(), savable.toMap());
    }
    batch.commit(noResult: true);
  }

  Future<int> update(Savable savable) async {
    return await _database.update(savable.getTableName(), savable.toMap(),
        where: savable.getArgs(), whereArgs: savable.getArgValues());
  }

  Future<int> delete(Savable savable) async {
    return _database.delete(savable.getTableName(),
        where: savable.getArgs(), whereArgs: savable.getArgValues());
  }

  Future<int> deleteAll(String tableName) async {
    return _database.delete(tableName);
  }

  dynamic executeQuery(String sql) async {
    return _database.rawQuery(sql);
  }
}
