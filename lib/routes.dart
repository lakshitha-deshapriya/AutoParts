import 'package:auto_parts/widgets/tab_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String initial = '/';
  static const String tabNavigator = '/navigator';
  static const String partItem = '/part';
}

class Routes {
  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   print('came here');
  //   switch (settings.name) {
  //     case RouteName.initial:
  //       return PlatformPageRoute(child: TabNavigator(), settings: settings)
  //           .build();
  //     case RouteName.partItem:
  //       return PlatformPageRoute(child: ShowPart(), settings: settings).build();
  //     default:
  //       return null;
  //   }
  // }

  static Map<String, WidgetBuilder> routesList(BuildContext ctx) {
    return {
      RouteName.tabNavigator: (ctx) => TabNavigator(),
      // RouteName.partItem: (ctx) => PartDetails(),
    };
  }
}
