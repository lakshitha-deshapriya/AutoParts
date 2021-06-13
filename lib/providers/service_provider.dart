import 'dart:async';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceProvider with ChangeNotifier {
  bool _initialized = false;

  String _intializedServiceCategory = '';

  Map<int, List<Service>> _serviceMap = {};
  Map<int, List<QueryDocumentSnapshot>> _snapshotMap = {};
  Map<int, bool> _nextLoadingMap = {};

  initForCategory(int categoryId) async {
    if (!_serviceMap.containsKey(categoryId)) {
      QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.servicesCollection)
          .where(Service.categoriesKey, arrayContainsAny: [categoryId])
          .orderBy(Constant.serviceInitialSort, descending: true)
          .limit(Constant.servicesLimit)
          .get();

      List<QueryDocumentSnapshot> snapshots = _querySnapshot.docs;

      List<Service> services =
          snapshots.map((doc) => Service.fromJson(doc)).toList();

      _serviceMap[categoryId] = services;
      _snapshotMap[categoryId] = snapshots;

      _nextLoadingMap[categoryId] = snapshots.length != Constant.servicesLimit;

      setInitializedCategoryKey(categoryId);
    }
  }

  getNextPage(StreamController controller, int categoryId) async {
    if (!_nextLoadingMap.containsKey(categoryId)) {
      _nextLoadingMap[categoryId] = true;

      List<QueryDocumentSnapshot> snapshots = _snapshotMap[categoryId];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.partsCollection)
          .orderBy(Constant.initialSort, descending: true)
          .startAfterDocument(snapshots[snapshots.length - 1])
          .limit(Constant.partsLimit)
          .get();

      List<QueryDocumentSnapshot> nextSnapshots = querySnapshot.docs;

      if (nextSnapshots.length > 0) {
        List<Service> newServices =
            nextSnapshots.map((doc) => Service.fromJson(doc)).toList();

        _serviceMap[categoryId].addAll(newServices);
        _snapshotMap[categoryId].addAll(nextSnapshots);

        controller.add(_serviceMap[categoryId]);

        if (nextSnapshots.length == Constant.servicesLimit) {
          _nextLoadingMap[categoryId] = false;
        }
      }
    }
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  bool isCategoryInitialized(int categoryId) {
    return _serviceMap.containsKey(categoryId);
  }

  String get initializedCategoryKey => _intializedServiceCategory;
  setInitializedCategoryKey(int categoryId) {
    _intializedServiceCategory = categoryId.toString();
    notifyListeners();
  }

  addDataToStream(StreamController streamController, int categoryId) {
    streamController.add(_serviceMap[categoryId]);
  }

  hasDataForCategory(int category) {
    return _serviceMap[category] != null && _serviceMap[category].isNotEmpty;
  }
}
