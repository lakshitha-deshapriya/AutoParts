import 'package:auto_parts/handlers/database_handler.dart';
import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/models/part_image.dart';
import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {
  List<Part> _favourites = [];
  Set<String> _favouriteIds = {};
  bool _initialized = false;

  init() async {
    loadFavourites();
  }

  loadFavourites() async {
    DatabaseHandler handler = DatabaseHandler();
    await handler.openConnection();
    _favourites = await handler
        .getAll(Part.tableName)
        .then((value) => value.map((map) => Part.fromMapObject(map)).toList());

    for (Part part in _favourites) {
      _favouriteIds.add(part.id);
      List<PartImage> images = await handler
          .executeQuery(PartImage.loadQuery, [part.id]).then((value) =>
              value.map((map) => PartImage.fromMapObject(map)).toList());
      part.images = images;
    }
    _initialized = true;
  }

  bool get isInitialized => _initialized;

  bool isFavourite(String id) {
    return _favouriteIds.contains(id);
  }

  List<Part> get favourites => _favourites;
}
