import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/theme_widget/theme_widget.dart';

class ThemeBorderContainer extends ThemeWidget<Widget> {
  final double borderWidth;
  final double borderRadius;
  final Widget child;

  ThemeBorderContainer({
    this.borderWidth = 0.0,
    this.borderRadius = 0.0,
    @required this.child,
    bool forceDark,
    Color darkColor,
    Color lightColor,
  }) : super(
            forceDark: forceDark, darkColor: darkColor, lightColor: lightColor);
  @override
  Widget createDarkWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return createWidget(context, color, forceIos, forceMaterial);
  }

  @override
  Widget createLightWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return createWidget(context, color, forceIos, forceMaterial);
  }

  Widget createWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
          color: color,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}
