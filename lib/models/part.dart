import 'package:cloud_firestore/cloud_firestore.dart';

class Part {
  String name;
  String brand;
  String model;
  String year;
  DateTime entered;
  DateTime modified;

  Part({
    this.name,
    this.brand,
    this.model,
    this.year,
    this.entered,
    this.modified,
  });

  factory Part.fromJson(dynamic json) {
    Timestamp entered = json['entered'];
    Timestamp modified = json['modified'];
    return Part(
      name: json['name'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      entered:
          DateTime.fromMicrosecondsSinceEpoch(entered.microsecondsSinceEpoch),
      modified:
          DateTime.fromMicrosecondsSinceEpoch(modified.microsecondsSinceEpoch),
    );
  }
}
