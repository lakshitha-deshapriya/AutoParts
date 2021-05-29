import 'package:auto_parts/models/part_image.dart';
import 'package:auto_parts/models/savable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Part extends Savable {
  static String tableName = 'PARTS';

  String id;
  String name;
  String brand;
  String model;
  String year;
  String condition;
  String description;
  DateTime entered;
  DateTime modified;
  String cur;
  double price;
  String coverUrl;
  List<PartImage> images;

  Part({
    this.id,
    this.name,
    this.brand,
    this.model,
    this.year,
    this.condition,
    this.description,
    this.entered,
    this.modified,
    this.cur,
    this.price,
    this.coverUrl,
    this.images,
  });

  static final idKey = 'id';
  static final enteredKey = 'entered';
  static final modifiedKey = 'modified';
  static final nameKey = 'name';
  static final brandKey = 'brand';
  static final modelKey = 'model';
  static final yearKey = 'year';
  static final conditionKey = 'condition';
  static final descriptionKey = 'desc';
  static final curKey = 'cur';
  static final priceKey = 'price';
  static final coverUrlKey = 'cover';
  static final imagesKey = 'images';

  static final String idCol = 'ID';
  static final String nameCol = 'NAME';
  static final String brandCol = 'BRAND';
  static final String modelCol = 'MODEL';
  static final String yearCol = 'YEAR';
  static final String conditionCol = 'CONDITION';
  static final String descriptionCol = 'DESC';
  static final String curCol = 'CUR';
  static final String priceCol = 'PRICE';
  static final String coverUrlCol = 'COVER_URL';
  static final String enteredCol = 'ENTERED';
  static final String modifiedCol = 'MODIFIED';

  static final Map<String, String> colMap = {
    idCol: 'TEXT PRIMARY KEY',
    nameCol: 'TEXT',
    brandCol: 'TEXT',
    modelCol: 'TEXT',
    yearCol: 'TEXT',
    conditionCol: 'TEXT',
    descriptionCol: 'TEXT',
    curCol: 'TEXT',
    priceCol: 'REAL',
    coverUrlCol: 'TEXT',
    enteredCol: 'INTEGER',
    modifiedCol: 'INTEGER',
  };

  factory Part.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data();

    String id = jsonData[idKey];
    String name = jsonData[nameKey];
    String brand = jsonData[brandKey];
    String model = jsonData[modelKey];
    String year = jsonData[yearKey]?.toString() ?? 'Any';
    String condition = jsonData[conditionKey]?.toString() ?? '(Not specified)';
    String description =
        jsonData[descriptionKey]?.toString() ?? '(Description)';
    Timestamp enteredTimestamp = jsonData[enteredKey];
    Timestamp modifiedTimestamp = jsonData[modifiedKey];
    String cur = jsonData[curKey];
    int price = jsonData[priceKey];
    String coverUrl = jsonData[coverUrlKey]?.toString() ?? '';
    List<PartImage> images = jsonData.containsKey(imagesKey)
        ? List<String>.from(jsonData[imagesKey])
            .map((imageUrl) => PartImage(id: id, imageUrl: imageUrl))
            .toList()
        : [];

    DateTime entered = DateTime.fromMicrosecondsSinceEpoch(
        enteredTimestamp.microsecondsSinceEpoch);
    DateTime modified = DateTime.fromMicrosecondsSinceEpoch(
        modifiedTimestamp.microsecondsSinceEpoch);

    return Part(
      id: id,
      name: name,
      brand: brand,
      model: model,
      year: year,
      condition: condition,
      description: description,
      entered: entered,
      modified: modified,
      cur: cur,
      price: price.toDouble(),
      coverUrl: coverUrl,
      images: images,
    );
  }

  static String getOnCreateSql() {
    String partSql = 'CREATE TABLE' + tableName + '( ';
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
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[idCol] = id;
    map[nameCol] = name;
    map[brandCol] = brand;
    map[modelCol] = model;
    map[yearCol] = year;
    map[conditionCol] = condition;
    map[descriptionCol] = description;
    map[curCol] = cur;
    map[priceCol] = price;
    map[coverUrlCol] = coverUrl;
    map[enteredCol] = entered.millisecondsSinceEpoch;
    map[modifiedCol] = modified.millisecondsSinceEpoch;
    return map;
  }

  factory Part.fromMapObject(Map<String, dynamic> map) {
    return Part(
      id: map[idCol],
      name: map[nameCol],
      brand: map[brandCol],
      model: map[modelCol],
      year: map[yearCol],
      condition: map[conditionCol],
      description: map[descriptionCol],
      cur: map[curCol],
      price: map[priceCol],
      coverUrl: map[coverUrlCol],
      entered: DateTime.fromMillisecondsSinceEpoch(map[enteredCol]),
      modified: DateTime.fromMillisecondsSinceEpoch(map[modifiedCol]),
    );
  }
}
