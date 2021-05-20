import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/providers/provider_manager.dart';
import 'package:auto_parts/routes.dart';
import 'package:auto_parts/widgets/tab_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      forceMaterial: Constant.forceMaterial,
      title: 'Auto Parts',
      initialRoute: RouteName.initial,
      home: TabNavigator(),
      routesList: Routes.routesList(context),
    );
  }
}
