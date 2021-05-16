import 'package:auto_parts/providers/parts_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<PartsProvider>(
    create: (context) => PartsProvider(),
  ),
];
