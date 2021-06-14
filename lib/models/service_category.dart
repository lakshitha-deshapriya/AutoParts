import 'package:auto_parts/models/savable.dart';

class ServiceCategory extends Savable {
  static final String tableName = 'SERVICE_CATEGORY';

  int id;
  String categoryName;
  String coverUrl;
  DateTime dateTime;

  ServiceCategory({
    this.id,
    this.categoryName,
    this.coverUrl,
    this.dateTime,
  });

  static final idKey = 'id';
  static final categoryKey = 'category';
  static final coverUrlKey = 'cover';

  static final String idCol = 'ID';
  static final String nameCol = 'NAME';
  static final String coverUrlCol = 'COVER_URL';
  static final String dateTimeCol = 'DATE_TIME';

  static final Map<String, String> colMap = {
    idCol: 'NUMBER PRIMARY KEY',
    nameCol: 'TEXT',
    coverUrlCol: 'TEXT',
    dateTimeCol: 'INTEGER',
  };

  factory ServiceCategory.fromJson(dynamic json) {
    int id = json[idKey];
    String category = json[categoryKey];
    String coverUrl = json[coverUrlKey]?.toString() ?? '';

    return ServiceCategory(
      id: id,
      categoryName: category,
      coverUrl: coverUrl,
      dateTime: DateTime.now(),
    );
  }

  static String getOnCreateSql() {
    String partSql = 'CREATE TABLE ' + tableName + ' ( ';
    int partIndex = 1;
    colMap.forEach((key, value) {
      partSql = partSql + key + ' ' + value;
      if (partIndex != colMap.length) {
        partSql = partSql + ', ';
      } else {
        partSql = partSql + ' )';
      }
      partIndex++;
    });
    return partSql;
  }

  @override
  String getTableName() {
    return tableName;
  }

  @override
  String getArgs() {
    return "ID = ?";
  }

  @override
  List<dynamic> getArgValues() {
    return [id];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[idCol] = id;
    map[nameCol] = categoryName;
    map[coverUrlCol] = coverUrl;
    map[dateTimeCol] = dateTime.millisecondsSinceEpoch;
    return map;
  }

  factory ServiceCategory.fromMapObject(Map<String, dynamic> map) {
    return ServiceCategory(
      id: map[idCol],
      categoryName: map[nameCol],
      coverUrl: map[coverUrlCol],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map[dateTimeCol]),
    );
  }
}
