import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/platform_specific/platform_widget.dart';

class PlatformTextField extends PlatformWidget<CupertinoTextField, TextField> {
  final TextEditingController controller;
  final String placeHolder;
  final TextStyle placeHolderStyle;
  final Color fillColor;
  final bool enabled;
  final double radius;
  final bool obscureText;
  final Color borderColor;
  final Color focusedBorderColor;
  final double insidePadding;
  final Widget prefixIcon;
  final int maxLines;
  final TextStyle textStyle;
  final Color cursorColor;

  PlatformTextField({
    this.controller,
    this.placeHolder,
    this.placeHolderStyle,
    this.fillColor,
    this.enabled = true,
    this.radius = 4.0,
    this.obscureText = false,
    this.borderColor = Colors.transparent,
    this.focusedBorderColor,
    this.insidePadding = 0.0,
    this.prefixIcon,
    this.maxLines = 1,
    this.textStyle,
    this.cursorColor,
    bool forceMaterial,
    bool forceIos,
  }) : super(forceMaterial: forceMaterial, forceIos: forceIos);

  @override
  TextField createAndroidWidget(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: insidePadding),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: focusedBorderColor == null
                  ? borderColor
                  : focusedBorderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        enabled: true,
        hintText: placeHolder,
        hintStyle: placeHolderStyle,
        filled: true,
        fillColor: fillColor,
      ),
      maxLines: maxLines,
      obscureText: obscureText,
      autocorrect: false,
      style: textStyle,
      cursorColor: cursorColor,
    );
  }

  @override
  CupertinoTextField createIosWidget(BuildContext context) {
    return CupertinoTextField(
      prefix: prefixIcon,
      padding: EdgeInsets.symmetric(horizontal: insidePadding),
      controller: controller,
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardAppearance: MediaQuery.of(context).platformBrightness,
      enabled: enabled,
      obscureText: obscureText,
      placeholder: placeHolder,
      placeholderStyle: placeHolderStyle,
      autocorrect: false,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      style: textStyle,
      cursorColor: cursorColor,
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(width: 0, color: CupertinoColors.systemGrey),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
