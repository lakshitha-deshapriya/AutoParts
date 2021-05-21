import 'package:cloud_firestore/cloud_firestore.dart';

class Part {
  String name;
  String brand;
  String model;
  String year;
  DateTime entered;
  DateTime modified;
  String cur;
  double price;
  String coverUrl;

  static final enteredKey = 'entered';
  static final modifiedKey = 'modified';
  static final nameKey = 'name';
  static final brandKey = 'brand';
  static final modelKey = 'model';
  static final yearKey = 'year';
  static final curKey = 'cur';
  static final priceKey = 'price';
  static final coverUrlKey = 'cover';

  Part({
    this.name,
    this.brand,
    this.model,
    this.year,
    this.entered,
    this.modified,
    this.cur,
    this.price,
    this.coverUrl,
  });

  factory Part.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data();

    String name = jsonData[nameKey];
    String brand = jsonData[brandKey];
    String model = jsonData[modelKey];
    String year = jsonData[yearKey];
    Timestamp enteredTimestamp = jsonData[enteredKey];
    Timestamp modifiedTimestamp = jsonData[modifiedKey];
    String cur = jsonData[curKey];
    int price = jsonData[priceKey];
    String coverUrl = jsonData[coverUrlKey]?.toString() ?? '';

    DateTime entered = DateTime.fromMicrosecondsSinceEpoch(
        enteredTimestamp.microsecondsSinceEpoch);
    DateTime modified = DateTime.fromMicrosecondsSinceEpoch(
        modifiedTimestamp.microsecondsSinceEpoch);

    return Part(
      name: name,
      brand: brand,
      model: model,
      year: year,
      entered: entered,
      modified: modified,
      cur: cur,
      price: price.toDouble(),
      coverUrl: coverUrl,
    );
  }
}
