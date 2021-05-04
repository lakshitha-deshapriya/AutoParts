import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';
import 'package:widget_lib/widgets/theme_widget/theme_widget.dart';

class ThemeTextField extends ThemeWidget<Widget> {
  final TextEditingController controller;
  final String placeHolder;
  final TextStyle lightPlaceHolderStyle;
  final TextStyle darkPlaceHolderStyle;
  final TextStyle lightTextStyle;
  final TextStyle darkTextStyle;
  final Color lightFillColor;
  final Color darkFllColor;
  final Color lightTextColor;
  final Color darkTextColor;
  final bool enabled;
  final double radius;
  final bool obscureText;
  final Color lightBorderColor;
  final Color darkBorderColor;
  final Color focusedBorderColor;
  final double insidePadding;
  final Widget prefixIcon;
  final int maxLines;

  ThemeTextField({
    this.controller,
    this.placeHolder,
    this.lightPlaceHolderStyle,
    this.darkPlaceHolderStyle,
    this.lightTextStyle,
    this.darkTextStyle,
    this.lightFillColor,
    this.darkFllColor,
    this.lightTextColor,
    this.darkTextColor,
    this.enabled = true,
    this.radius = 4.0,
    this.obscureText = false,
    this.lightBorderColor = Colors.transparent,
    this.darkBorderColor = Colors.transparent,
    this.focusedBorderColor,
    this.insidePadding = 0.0,
    this.prefixIcon,
    this.maxLines = 1,
    bool forceDark,
    bool forceIos,
    bool forceMaterial,
  }) : super(
          forceDark: forceDark,
          forceIos: forceIos,
          forceMaterial: forceMaterial,
        );

  @override
  Widget createDarkWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    final double width = MediaQuery.of(context).size.width;

    final TextStyle textStyle = darkTextStyle ??
        TextStyle(
          color: darkTextColor ?? color,
          fontSize: width * 0.04,
        );

    final TextStyle holderStyle = darkPlaceHolderStyle ??
        TextStyle(
          color: CupertinoColors.systemGrey,
          fontSize: width * 0.04,
        );

    final Color fillColor = darkFllColor ?? CupertinoColors.systemGrey3;

    return PlatformTextField(
      controller: controller,
      placeHolder: placeHolder,
      placeHolderStyle: holderStyle,
      radius: radius,
      enabled: enabled,
      obscureText: obscureText,
      insidePadding: insidePadding,
      fillColor: fillColor,
      focusedBorderColor: focusedBorderColor,
      borderColor: darkBorderColor,
      prefixIcon: prefixIcon,
      textStyle: textStyle,
      maxLines: maxLines,
      cursorColor: CupertinoColors.white.withAlpha(50),
      forceIos: forceIos,
      forceMaterial: forceMaterial,
    );
  }

  @override
  Widget createLightWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    final double width = MediaQuery.of(context).size.width;

    final TextStyle textStyle = lightTextStyle ??
        TextStyle(
          color: lightTextColor ?? color,
          fontSize: width * 0.04,
        );

    final TextStyle holderStyle = darkPlaceHolderStyle ??
        TextStyle(
          color: CupertinoColors.systemGrey,
          fontSize: width * 0.04,
        );

    final Color fillColor =
        lightFillColor ?? CupertinoColors.systemGrey.withOpacity(0.1);

    return PlatformTextField(
      controller: controller,
      placeHolder: placeHolder,
      placeHolderStyle: holderStyle,
      radius: radius,
      enabled: enabled,
      obscureText: obscureText,
      insidePadding: insidePadding,
      fillColor: fillColor,
      focusedBorderColor: focusedBorderColor,
      borderColor: lightBorderColor,
      prefixIcon: prefixIcon,
      textStyle: textStyle,
      maxLines: maxLines,
      cursorColor: CupertinoColors.systemGrey,
      forceIos: forceIos,
      forceMaterial: forceMaterial,
    );
  }
}
