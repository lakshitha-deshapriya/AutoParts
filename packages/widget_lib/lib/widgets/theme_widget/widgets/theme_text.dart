import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/theme_widget/theme_widget.dart';

class ThemeText extends ThemeWidget<Text> {
  final String data;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior textHeightBehavior;

  ThemeText(
    this.data, {
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    bool forceDark,
    Color darkColor,
    Color lightColor,
  }) : super(
            forceDark: forceDark, darkColor: darkColor, lightColor: lightColor);

  TextStyle getTextStyle(TextStyle style, Color color) {
    TextStyle textStyle = style;
    if (textStyle == null) {
      textStyle = TextStyle();
    }

    if (textStyle.color == null) {
      textStyle = textStyle.copyWith(color: color);
    }
    return textStyle;
  }

  @override
  Text createDarkWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return Text(
      data,
      key: key,
      style: getTextStyle(style, color),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }

  @override
  Text createLightWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return Text(
      data,
      key: key,
      style: getTextStyle(style, color),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
