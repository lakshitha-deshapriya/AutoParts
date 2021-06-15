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
  List<Part> _filteredParts = [];

  List<Service> _favouriteServices = [];
  Set<String> _favouriteServiceIds = {};
  List<Service> _filteredServices = [];

  bool _initialized = false;

  String _newFavouritePart = '';
  String _newFavouriteService = '';

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
    _filteredParts = _favouriteParts;

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
    _filteredServices = _favouriteServices;

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

  resetData() {
    _filteredParts = _favouriteParts;
    _filteredServices = _favouriteServices;
  }

  filterDataForPartSearch(String searchText) {
    if (searchText.isEmpty) {
      _filteredParts = _favouriteParts;
    } else {
      _filteredParts = _favouriteParts
          .where((part) =>
              part.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    setNewFavouritePart('Search for:' + searchText);
  }

  filterDataForServiceSearch(String searchText) {
    if (searchText.isEmpty) {
      _filteredServices = _favouriteServices;
    } else {
      _filteredServices = _favouriteServices
          .where((service) =>
              service.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    setNewFavouriteService('Search for:' + searchText);
  }

  bool get isInitialized => _initialized;
  setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  List<Part> get favouriteParts => _favouriteParts;
  List<Part> get filteredFavouriteParts => _filteredParts;

  List<Service> get favouriteServices => _favouriteServices;
  List<Service> get filteredFavouriteServices => _filteredServices;

  String get newFavouritePart => _newFavouritePart;
  setNewFavouritePart(String str) {
    _newFavouritePart = str;
    notifyListeners();
  }

  String get newFavouriteService => _newFavouriteService;
  setNewFavouriteService(String str) {
    _newFavouriteService = str;
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

    setNewFavouritePart(part.id);
  }

  removeFromFavouriteParts(Part part) async {
    await removePartFromDb(part);

    await loadFavourites();

    setNewFavouritePart('changed' + part.id);
  }

  addToFavouriteServices(Service service) async {
    await insertServiceToDb(service);

    await loadFavourites();

    setNewFavouriteService(service.id);
  }

  removeFromFavouriteServices(Service service) async {
    await removeServiceFromDb(service);

    await loadFavourites();

    setNewFavouriteService('changed ' + service.id);
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
