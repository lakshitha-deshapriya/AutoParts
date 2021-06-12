import 'package:auto_parts/models/savable.dart';
import 'package:auto_parts/models/service_category_data.dart';
import 'package:auto_parts/models/service_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Service extends Savable {
  static String tableName = 'SERVICES';

  String id;
  String name;
  String coverUrl;
  DateTime entered;
  DateTime modified;
  List<ServiceImage> images;
  List<ServiceCategoryData> categories;

  Service({
    this.id,
    this.name,
    this.coverUrl,
    this.entered,
    this.modified,
    this.images,
    this.categories,
  });

  static final idKey = 'id';
  static final nameKey = 'name';
  static final coverUrlKey = 'cover';
  static final enteredKey = 'entered';
  static final modifiedKey = 'modified';
  static final categoriesKey = 'category';
  static final imagesKey = 'images';

  static final String idCol = 'ID';
  static final String nameCol = 'NAME';
  static final String coverUrlCol = 'COVER_URL';
  static final String enteredCol = 'ENTERED';
  static final String modifiedCol = 'MODIFIED';

  static final Map<String, String> colMap = {
    idCol: 'TEXT PRIMARY KEY',
    nameCol: 'TEXT',
    coverUrlCol: 'TEXT',
    enteredCol: 'INTEGER',
    modifiedCol: 'INTEGER',
  };

  factory Service.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data();

    String id = jsonData[idKey];
    String name = jsonData[nameKey];
    String coverUrl = jsonData[coverUrlKey]?.toString() ?? '';
    Timestamp enteredTimestamp = jsonData[enteredKey];
    Timestamp modifiedTimestamp = jsonData[modifiedKey];
    List<ServiceImage> images = jsonData.containsKey(imagesKey)
        ? List<String>.from(jsonData[imagesKey])
            .map((imageUrl) => ServiceImage(id: id, imageUrl: imageUrl))
            .toList()
        : [];
    List<ServiceCategoryData> categories = jsonData.containsKey(categoriesKey)
        ? (jsonData[categoriesKey] as List)
            .map((category) => ServiceCategoryData(id: id, category: int.parse(category.toString())))
            .toList()
        : [];

    DateTime entered = DateTime.fromMicrosecondsSinceEpoch(
        enteredTimestamp.microsecondsSinceEpoch);
    DateTime modified = DateTime.fromMicrosecondsSinceEpoch(
        modifiedTimestamp.microsecondsSinceEpoch);

    return Service(
      id: id,
      name: name,
      coverUrl: coverUrl,
      entered: entered,
      modified: modified,
      images: images,
      categories: categories,
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
    map[nameCol] = name;
    map[coverUrlCol] = coverUrl;
    map[enteredCol] = entered.millisecondsSinceEpoch;
    map[modifiedCol] = modified.millisecondsSinceEpoch;
    return map;
  }

  factory Service.fromMapObject(Map<String, dynamic> map) {
    return Service(
      id: map[idCol],
      name: map[nameCol],
      coverUrl: map[coverUrlCol],
      entered: DateTime.fromMillisecondsSinceEpoch(map[enteredCol]),
      modified: DateTime.fromMillisecondsSinceEpoch(map[modifiedCol]),
    );
  }
}
