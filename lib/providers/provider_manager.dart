import 'package:auto_parts/providers/favourite_provider.dart';
import 'package:auto_parts/providers/meta_data_provider.dart';
import 'package:auto_parts/providers/parts_provider.dart';
import 'package:auto_parts/providers/service_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<PartsProvider>(
    create: (context) => PartsProvider(),
  ),
  ChangeNotifierProvider<FavouriteProvider>(
    create: (context) => FavouriteProvider(),
  ),
  ChangeNotifierProvider<ServiceProvider>(
    create: (context) => ServiceProvider(),
  ),
  ChangeNotifierProvider<MetaDataProvider>(
    create: (context) => MetaDataProvider(),
  ),
];
