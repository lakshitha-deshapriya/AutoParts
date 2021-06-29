import 'dart:async';
import 'dart:convert';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/handlers/http_data_handler.dart';
import 'package:auto_parts/models/part.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PartsProvider with ChangeNotifier {
  bool _initialized = false;
  bool _nextLoading = false;

  List<Part> _parts = [];
  List<DocumentSnapshot> _snapshots = [];

  init() async {
    if (!_initialized) {
      if (Constant.useFirebase) {
        await loadPartsFromFirebase();
      } else {
        await loadPartsFromServer('search');
      }

      setInitialized(true);
    }
  }

  getNextPage(StreamController controller) async {
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

        controller.add(_parts);

        if (_snapshots.length == Constant.partsLimit) {
          _nextLoading = false;
        }
      }
    }
  }

  loadPartsFromServer(String apiUrl) async {
    List<Part> parts = [];
    try {
      var res =
          await HttpDataHandler().get(Constant.getBaseUrl(), apiUrl);

      for (var json in json.decode(res) as List) {
        parts.add(Part.fromServerJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    _parts.addAll(parts);
    if (Constant.partsLimit == parts.length) {
      _nextLoading = false;
    }
  }

  loadPartsFromFirebase() async {
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.partsCollection)
        .orderBy(Constant.initialSort, descending: true)
        .limit(Constant.partsLimit)
        .get();

    _snapshots = _querySnapshot.docs;

    _snapshots.forEach((doc) {
      _parts.add(Part.fromJson(doc));
    });
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  addDataToStream(StreamController streamController) {
    streamController.add(_parts);
  }

  bool get hasNext => !_nextLoading;
}
