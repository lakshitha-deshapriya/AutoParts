import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class NavigationUtil {
  static navigatePush(BuildContext context, Widget child) {
    return Navigator.push(context, PlatformPageRoute(child: child).build());
  }
}
