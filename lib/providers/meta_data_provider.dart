import 'dart:convert';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/service_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MetaDataProvider with ChangeNotifier {
  bool _initialized = false;

  List<ServiceCategory> _serviceCategories = [];

  init() async {
    if (!_initialized) {
      QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.metaDataCollection)
          .get();

      DocumentSnapshot snapshot = _querySnapshot.docs[0];

      var metaJson = jsonDecode(snapshot[Constant.metaDataKey]);

      var serviceCategories = metaJson[Constant.serviceCatKey] as List;

      _serviceCategories = serviceCategories
          .map((json) => ServiceCategory.fromJson(json))
          .toList();

      setInitialized(true);
    }
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  List<ServiceCategory> get serviceCategories => _serviceCategories;
}
