import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/utils/widget_util.dart';

abstract class ThemeWidget<I extends Widget> extends StatelessWidget {
  final bool forceDark;
  final Color darkColor;
  final Color lightColor;
  final bool forceIos;
  final bool forceMaterial;

  ThemeWidget({
    this.forceDark,
    this.darkColor,
    this.lightColor,
    this.forceIos,
    this.forceMaterial,
  });

  @override
  Widget build(BuildContext context) {
    final bool darkMode = WidgetUtil.isDarkMode(context);
    if (forceDark != null && forceDark) {
      final Color color = darkColor != null ? darkColor : CupertinoColors.white;
      return createDarkWidget(context, color, forceIos, forceMaterial);
    }

    if (darkMode) {
      final Color color = darkColor != null ? darkColor : CupertinoColors.white;
      return createDarkWidget(context, color, forceIos, forceMaterial);
    } else {
      final Color color =
          lightColor != null ? lightColor : CupertinoColors.black;
      return createLightWidget(context, color, forceIos, forceMaterial);
    }
  }

  I createLightWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial);

  I createDarkWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial);
}
