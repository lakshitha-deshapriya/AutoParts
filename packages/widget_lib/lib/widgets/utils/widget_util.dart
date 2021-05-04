import 'package:flutter/material.dart';

class WidgetUtil {
  static bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}
