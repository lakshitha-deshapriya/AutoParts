import 'package:auto_parts/handlers/database_handler.dart';
import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/models/part_image.dart';
import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {
  List<Part> _favouriteParts = [];
  Set<String> _favouritePartIds = {};
  bool _initialized = false;
  String _newFavouritePartId = '';

  init() async {
    loadFavourites();
  }

  loadFavourites() async {
    DatabaseHandler handler = DatabaseHandler();
    await handler.openConnection();
    _favouriteParts = await handler
        .getAll(Part.tableName)
        .then((value) => value.map((map) => Part.fromMapObject(map)).toList());

    _favouritePartIds.clear();
    for (Part part in _favouriteParts) {
      _favouritePartIds.add(part.id);
      List<PartImage> images = await handler
          .executeQuery(PartImage.loadQuery, [part.id]).then((value) =>
              value.map((map) => PartImage.fromMapObject(map)).toList());
      part.images = images;
    }
    _initialized = true;
    await handler.closeConnection();
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  List<Part> get favouriteParts => _favouriteParts;

  String get newFavouritePartId => _newFavouritePartId;
  setNewFavouritePartId(String id) {
    _newFavouritePartId = id;
    notifyListeners();
  }

  bool isFavouritePart(String id) {
    return _favouritePartIds.contains(id);
  }

  addToFavouriteParts(Part part) async {
    await insertPartToDb(part);

    await loadFavourites();

    setNewFavouritePartId(part.id);
  }

  removeFromFavouriteParts(Part part) async {
    await removePartFromDb(part);

    await loadFavourites();

    setNewFavouritePartId('changed');
  }

  insertPartToDb(Part part) async {
    DatabaseHandler handler = new DatabaseHandler();
    await handler.openConnection();

    int id = await handler.insert(part);
    if (id != 0) {
      await handler.insertAll(part.images);
    }

    await handler.closeConnection();
  }

  removePartFromDb(Part part) async {
    DatabaseHandler handler = new DatabaseHandler();
    await handler.openConnection();

    await handler.delete(part);

    if (part.images.isNotEmpty) {
      await handler.delete(part.images[0]);
    }

    await handler.closeConnection();
  }
}
