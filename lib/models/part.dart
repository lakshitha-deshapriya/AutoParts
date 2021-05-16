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

  static final List<String> jsonValiables = [
    'entered',
    'modified',
    'name',
    'brand',
    'model',
    'year',
    'cur',
    'price'
  ];

  Part({
    this.name,
    this.brand,
    this.model,
    this.year,
    this.entered,
    this.modified,
    this.cur,
    this.price,
  });

  factory Part.fromJson(dynamic json) {
    Timestamp entered = json[jsonValiables[0]];
    Timestamp modified = json[jsonValiables[1]];
    int price = json[jsonValiables[7]];
    return Part(
      name: json[jsonValiables[2]],
      brand: json[jsonValiables[3]],
      model: json[jsonValiables[4]],
      year: json[jsonValiables[5]],
      entered:
          DateTime.fromMicrosecondsSinceEpoch(entered.microsecondsSinceEpoch),
      modified:
          DateTime.fromMicrosecondsSinceEpoch(modified.microsecondsSinceEpoch),
      cur: json[jsonValiables[6]],
      price: price.toDouble(),
    );
  }
}
