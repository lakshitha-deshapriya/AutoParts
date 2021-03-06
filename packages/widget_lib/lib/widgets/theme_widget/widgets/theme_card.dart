import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/theme_widget/theme_widget.dart';

class ThemeCard extends ThemeWidget<Widget> {
  final double elevation;
  final double borderRadius;
  final Widget child;

  ThemeCard({
    this.elevation = 1.0,
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

  createWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return Card(
      color: color,
      elevation: elevation,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
