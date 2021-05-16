import 'dart:async';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/part.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PartsProvider with ChangeNotifier {
  StreamController<List<Part>> _streamController =
      StreamController<List<Part>>();
  bool _initialized = false;
  bool _nextLoading = false;

  List<Part> _parts = [];
  List<DocumentSnapshot> _snapshots = [];

  init() async {
    if (!_initialized) {
      QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.partsCollection)
          .orderBy(Constant.initialSort, descending: true)
          .limit(Constant.partsLimit)
          .get();

      _snapshots = _querySnapshot.docs;

      _snapshots.forEach((doc) {
        _parts.add(Part.fromJson(doc));
      });

      _streamController.add(_parts);
      _initialized = true;
    }
  }

  getNextPage() async {
    if (!_nextLoading) {
      _nextLoading = true;

      QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.partsCollection)
          .orderBy(Constant.initialSort, descending: true)
          .startAfterDocument(_snapshots[_snapshots.length - 1])
          .limit(Constant.partsLimit)
          .get();

      _snapshots = _querySnapshot.docs;

      if (_snapshots.length > 0) {
        _snapshots.forEach((doc) {
          _parts.add(Part.fromJson(doc));
        });

        _streamController.add(_parts);

        if (_snapshots.length == Constant.partsLimit) {
          _nextLoading = false;
        }
      }
    }
  }

  StreamController<List<Part>> get controller => _streamController;

  bool get hasNext => !_nextLoading;
}
