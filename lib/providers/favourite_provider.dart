import 'package:auto_parts/handlers/database_handler.dart';
import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/models/part_image.dart';
import 'package:auto_parts/models/service.dart';
import 'package:auto_parts/models/service_category_data.dart';
import 'package:auto_parts/models/service_image.dart';
import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {
  List<Part> _favouriteParts = [];
  Set<String> _favouritePartIds = {};

  List<Service> _favouriteServices = [];
  Set<String> _favouriteServiceIds = {};

  bool _initialized = false;
  String _newFavouritePartId = '';
  String _newFavouriteServiceId = '';

  init() async {
    loadFavourites();
  }

  loadFavourites() async {
    DatabaseHandler handler = DatabaseHandler();
    await handler.openConnection();

    //Load favourite part details
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

    //Load favourite service details
    _favouriteServices = await handler.getAll(Service.tableName).then(
        (value) => value.map((map) => Service.fromMapObject(map)).toList());

    _favouriteServiceIds.clear();
    for (Service service in _favouriteServices) {
      _favouriteServiceIds.add(service.id);

      service.images = await handler
          .executeQuery(ServiceImage.loadQuery, [service.id]).then((value) =>
              value.map((map) => ServiceImage.fromMapObject(map)).toList());

      service.categories = await handler
          .executeQuery(ServiceCategoryData.loadQuery, [service.id]).then(
              (value) => value
                  .map((map) => ServiceCategoryData.fromMapObject(map))
                  .toList());
    }

    _initialized = true;
    // await handler.closeConnection();
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  List<Part> get favouriteParts => _favouriteParts;

  List<Service> get favouriteServices => _favouriteServices;

  String get newFavouritePartId => _newFavouritePartId;
  setNewFavouritePartId(String id) {
    _newFavouritePartId = id;
    notifyListeners();
  }

  String get newFavouriteServiceId => _newFavouriteServiceId;
  setNewFavouriteServiceId(String id) {
    _newFavouriteServiceId = id;
    notifyListeners();
  }

  bool isFavouritePart(String id) {
    return _favouritePartIds.contains(id);
  }

  bool isFavouriteService(String id) {
    return _favouriteServiceIds.contains(id);
  }

  addToFavouriteParts(Part part) async {
    await insertPartToDb(part);

    await loadFavourites();

    setNewFavouritePartId(part.id);
  }

  removeFromFavouriteParts(Part part) async {
    await removePartFromDb(part);

    await loadFavourites();

    setNewFavouritePartId('changed' + part.id);
  }

  addToFavouriteServices(Service service) async {
    await insertServiceToDb(service); 

    await loadFavourites();

    setNewFavouriteServiceId(service.id);
  }

  removeFromFavouriteServices(Service service) async {
    await removeServiceFromDb(service);

    await loadFavourites();

    setNewFavouriteServiceId('changed ' + service.id);
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
      await handler
          .delete(part.images[0]); //zeroth element is used for the needed data
    }

    await handler.closeConnection();
  }

  insertServiceToDb(Service service) async {
    DatabaseHandler handler = new DatabaseHandler();
    await handler.openConnection();

    int id = await handler.insert(service);
    if (id != 0) {
      await handler.insertAll(service.images);

      await handler.insertAll(service.categories);
    }

    await handler.closeConnection();
  }

  removeServiceFromDb(Service service) async {
    DatabaseHandler handler = new DatabaseHandler();
    await handler.openConnection();

    await handler.delete(service);

    if (service.images.isNotEmpty) {
      await handler.delete(
          service.images[0]); //zeroth element is used for the needed data
    }

    if (service.categories.isNotEmpty) {
      await handler.delete(
          service.categories[0]); //zeroth element is used for the needed data
    }

    await handler.closeConnection();
  }
}
