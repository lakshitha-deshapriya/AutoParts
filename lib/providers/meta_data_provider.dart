import 'dart:convert';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/handlers/database_handler.dart';
import 'package:auto_parts/models/service_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MetaDataProvider with ChangeNotifier {
  bool _initialized = false;

  List<ServiceCategory> _serviceCategories = [];

  init() async {
    if (!_initialized) {
      await loadFromDB();

      if (_serviceCategories.isEmpty) {
        await loadFromFirebase();
      } else {
        DateTime nextInsertTime =
            _serviceCategories[0].dateTime.add(Duration(days: 1));

        if (nextInsertTime.isBefore(DateTime.now())) {
          await loadFromFirebase();
        }
      }

      setInitialized(true);
    }
  }

  loadFromDB() async {
    DatabaseHandler handler = DatabaseHandler();
    await handler.openConnection();

    _serviceCategories = await handler.getAll(ServiceCategory.tableName).then(
        (value) =>
            value.map((map) => ServiceCategory.fromMapObject(map)).toList());

    print('Loaded meta data from DB');
  }

  loadFromFirebase() async {
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.metaDataCollection)
        .get();

    DocumentSnapshot snapshot = _querySnapshot.docs[0];

    var metaJson = jsonDecode(snapshot[Constant.metaDataKey]);

    var serviceCategories = metaJson[Constant.serviceCatKey] as List;

    _serviceCategories = serviceCategories
        .map((json) => ServiceCategory.fromJson(json))
        .toList();

    print('Loaded meta data from firebase');

    insertToDB();
  }

  insertToDB() async {
    DatabaseHandler handler = new DatabaseHandler();
    await handler.openConnection();

    await handler.deleteAll(ServiceCategory.tableName);

    await handler.insertAll(_serviceCategories);
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  List<ServiceCategory> get serviceCategories => _serviceCategories;
}
