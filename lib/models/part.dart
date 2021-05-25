import 'package:cloud_firestore/cloud_firestore.dart';

class Part {
  String name;
  String brand;
  String model;
  String year;
  String condition;
  DateTime entered;
  DateTime modified;
  String cur;
  double price;
  String coverUrl;
  List<String> images;

  static final enteredKey = 'entered';
  static final modifiedKey = 'modified';
  static final nameKey = 'name';
  static final brandKey = 'brand';
  static final modelKey = 'model';
  static final yearKey = 'year';
  static final conditionKey = 'condition';
  static final curKey = 'cur';
  static final priceKey = 'price';
  static final coverUrlKey = 'cover';
  static final imagesKey = 'images';

  Part({
    this.name,
    this.brand,
    this.model,
    this.year,
    this.condition,
    this.entered,
    this.modified,
    this.cur,
    this.price,
    this.coverUrl,
    this.images,
  });

  factory Part.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data();

    String name = jsonData[nameKey];
    String brand = jsonData[brandKey];
    String model = jsonData[modelKey];
    String year = jsonData[yearKey];
    String condition = jsonData[conditionKey];
    Timestamp enteredTimestamp = jsonData[enteredKey];
    Timestamp modifiedTimestamp = jsonData[modifiedKey];
    String cur = jsonData[curKey];
    int price = jsonData[priceKey];
    String coverUrl = jsonData[coverUrlKey]?.toString() ?? '';
    List<String> images = jsonData.containsKey(imagesKey)
        ? List<String>.from(jsonData[imagesKey])
        : [];

    DateTime entered = DateTime.fromMicrosecondsSinceEpoch(
        enteredTimestamp.microsecondsSinceEpoch);
    DateTime modified = DateTime.fromMicrosecondsSinceEpoch(
        modifiedTimestamp.microsecondsSinceEpoch);

    return Part(
      name: name,
      brand: brand,
      model: model,
      year: year,
      condition: condition,
      entered: entered,
      modified: modified,
      cur: cur,
      price: price.toDouble(),
      coverUrl: coverUrl,
      images: images,
    );
  }
}
