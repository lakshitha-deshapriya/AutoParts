import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/theme_widget/theme_widget.dart';

class ThemeGradientBackground extends ThemeWidget<Widget> {
  ThemeGradientBackground({
    bool forceDark,
  }) : super(forceDark: forceDark);

  @override
  Widget createDarkWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return DecoratedBox(
      child: SizedBox.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.withAlpha(100),
            Colors.grey.withAlpha(180),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
        ),
      ),
    );
  }

  @override
  Widget createLightWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return DecoratedBox(
      child: SizedBox.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlueAccent,
            Colors.lightGreenAccent.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
        ),
      ),
    );
  }
}
