import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class PlatformRaisedButton extends PlatformWidget<Widget, Widget> {
  final Color color;
  final double elevation;
  final double height;
  final double width;
  final double radius;
  final Widget child;
  final EdgeInsets padding;
  final Function onPressed;

  PlatformRaisedButton({
    this.color,
    this.elevation = 0.0,
    this.height,
    this.width,
    this.radius = 4.0,
    @required this.child,
    this.padding = EdgeInsets.zero,
    @required this.onPressed,
    bool forceIos,
    bool forceMaterial,
  }) : super(forceIos: forceIos, forceMaterial: forceMaterial);

  @override
  Widget createAndroidWidget(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      height: height,
      width: width,
      child: RaisedButton(
        elevation: elevation,
        color: color ?? primaryColor,
        padding: padding,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: child,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        child: CupertinoButton(
          color: color ?? primaryColor,
          padding: padding,
          borderRadius: BorderRadius.circular(radius),
          child: child,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
