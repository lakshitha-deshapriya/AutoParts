import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class PlatformFlatButton extends PlatformWidget<Widget, Widget> {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  final Function onPressed;

  PlatformFlatButton({
    this.height,
    this.width,
    @required this.child,
    this.padding = EdgeInsets.zero,
    @required this.onPressed,
    bool forceIos,
    bool forceMaterial,
  }) : super(forceIos: forceIos, forceMaterial: forceMaterial);

  @override
  Widget createAndroidWidget(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      child: TextButton(
        child: child,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CupertinoButton(
        padding: padding,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
