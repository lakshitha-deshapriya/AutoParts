import 'package:auto_parts/models/savable.dart';

class ServiceCategoryData extends Savable {
  static final String tableName = 'SERVICE_CATEGORY_DATA';
  static final String loadQuery = 'SELECT * FROM ' + tableName + ' WHERE ID=?';

  String id;
  int category;

  ServiceCategoryData({
    this.id,
    this.category,
  });

  static final String idCol = 'ID';
  static final String categoryCol = 'CATEGORY';

  static final Map<String, String> serviceCategoryColMap = {
    idCol: 'TEXT',
    categoryCol: 'NUMBER',
  };

  static String getOnCreateSql() {
    String serviceCategorySql = 'CREATE TABLE ' + tableName + ' ( ';
    int categoryIndex = 1;
    serviceCategoryColMap.forEach((key, value) {
      serviceCategorySql = serviceCategorySql + key + ' ' + value + ', ';
      if (categoryIndex == serviceCategoryColMap.length) {
        serviceCategorySql = serviceCategorySql +
            'PRIMARY KEY ( ' +
            idCol +
            ', ' +
            categoryCol +
            ' ) )';
      }
      categoryIndex++;
    });
    return serviceCategorySql;
  }

  @override
  String getTableName() {
    return tableName;
  }

  @override
  String getArgs() {
    return 'ID = ?';
  }

  @override
  List<dynamic> getArgValues() {
    return [id];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[idCol] = id;
    map[categoryCol] = category;
    return map;
  }

  factory ServiceCategoryData.fromMapObject(Map<String, dynamic> map) {
    return ServiceCategoryData(
      id: map[idCol],
      category: map[categoryCol],
    );
  }
}
