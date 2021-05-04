import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/routes.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      forceMaterial: Constant.forceMaterial,
      title: 'Auto Parts',
      initialRoute: RouteName.initial,
      generatedRoutes: Routes.generateRoute,
      routesList: Routes.routesList(context),
    );
  }
}
