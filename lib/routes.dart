import 'package:auto_parts/widgets/tab_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class RouteName {
  static const String initial = '/';
  static const String tabNavigator = '/navigator';
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.initial:
        return PlatformPageRoute(child: TabNavigator(), settings: settings)
            .build();
      default:
        return null;
    }
  }

  static Map<String, WidgetBuilder> routesList(BuildContext ctx) {
    return {
      RouteName.tabNavigator: (ctx) => TabNavigator(),
    };
  }
}
