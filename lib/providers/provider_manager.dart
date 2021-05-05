import 'package:auto_parts/providers/ads_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<AdsProvider>(
    create: (context) => AdsProvider(),
  ),
];
