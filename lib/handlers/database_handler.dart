import 'dart:io';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/models/part_image.dart';
import 'package:auto_parts/models/savable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  static Database _database;

  Future<Database> openConnection() async {
    if (_database == null || !_database.isOpen) {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path + Constant.dbName;
      _database = await openDatabase(path,
          version: 1, onCreate: _createDb, onUpgrade: _upgradeDb);
    }
    return _database;
  }

  void _createDb(Database db, int version) async {
    String partSql = Part.getOnCreateSql();
    await db.execute(partSql);

    String partImageSql = PartImage.getOnCreateSql();
    await db.execute(partImageSql);
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

  Future insertAll(List<Savable> savables) async {
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

  Future<List<Map<String, dynamic>>> executeQuery(
      String sql, List<dynamic> arguments) async {
    if (arguments == null || arguments.isEmpty) {
      return await _database.rawQuery(sql);
    } else {
      return await _database.rawQuery(sql, arguments);
    }
  }
}
