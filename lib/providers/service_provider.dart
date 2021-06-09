import 'dart:async';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceProvider with ChangeNotifier {
  bool _initialized = false;
  bool _nextLoading = false;

  Map<int, List<Service>> _serviceMap = {};

  initForCategory(int categoryId) async {
    if (!_serviceMap.containsKey(categoryId)) {
      QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.servicesCollection)
          .where(Service.categoriesKey, arrayContainsAny: [categoryId])
          .orderBy(Constant.serviceInitialSort, descending: true)
          .limit(Constant.servicesLimit)
          .get();

      List<QueryDocumentSnapshot> _snapshots = _querySnapshot.docs;

      List<Service> services =
          _snapshots.map((doc) => Service.fromJson(doc)).toList();

      _serviceMap[categoryId] = services;
      
      setInitialized(true);
    }
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  addDataToStream(StreamController streamController, int categoryId) {
    streamController.add(_serviceMap[categoryId]);
  }

  bool get hasNext => !_nextLoading;
}
