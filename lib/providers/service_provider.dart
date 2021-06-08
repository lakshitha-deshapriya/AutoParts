import 'dart:async';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceProvider with ChangeNotifier {
  bool _initialized = false;
  bool _nextLoading = false;

  List<Service> _services = [];
  List<DocumentSnapshot> _snapshots = [];

  init() async {
    if (!_initialized) {
      QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.servicesCollection)
          .orderBy(Constant.serviceInitialSort, descending: true)
          .limit(Constant.servicesLimit)
          .get();

      _snapshots = _querySnapshot.docs;

      _snapshots.forEach((doc) {
        _services.add(Service.fromJson(doc));
      });

      setInitialized(true);
    }
  }

  getNextPage(StreamController controller) async {
    if (!_nextLoading) {
      _nextLoading = true;

      QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.servicesCollection)
          .orderBy(Constant.serviceInitialSort, descending: true)
          .startAfterDocument(_snapshots[_snapshots.length - 1])
          .limit(Constant.servicesLimit)
          .get();

      _snapshots = _querySnapshot.docs;

      if (_snapshots.length > 0) {
        _snapshots.forEach((doc) {
          _services.add(Service.fromJson(doc));
        });

        controller.add(_services);

        if (_snapshots.length == Constant.servicesLimit) {
          _nextLoading = false;
        }
      }
    }
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  addDataToStream(StreamController streamController) {
    streamController.add(_services);
  }

  bool get hasNext => !_nextLoading;
}
