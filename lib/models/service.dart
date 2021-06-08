import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  String id;
  String name;
  String coverUrl;
  DateTime entered;
  DateTime modified;
  List<String> categories;

  Service({
    this.id,
    this.name,
    this.coverUrl,
    this.entered,
    this.modified,
    this.categories,
  });

  static final idKey = 'id';
  static final nameKey = 'name';
  static final coverUrlKey = 'cover';
  static final enteredKey = 'entered';
  static final modifiedKey = 'modified';
  static final categoriesKey = 'category';

  factory Service.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data();

    String id = jsonData[idKey];
    String name = jsonData[nameKey];
    String coverUrl = jsonData[coverUrlKey]?.toString() ?? '';
    Timestamp enteredTimestamp = jsonData[enteredKey];
    Timestamp modifiedTimestamp = jsonData[modifiedKey];
    List<String> categories =
        jsonData.containsKey(categoriesKey) ? jsonData[categoriesKey] : [];

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
      categories: categories,
    );
  }
}
