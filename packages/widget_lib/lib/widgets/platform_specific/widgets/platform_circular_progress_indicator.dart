import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class PlatformCircularProgressIndicator
    extends PlatformWidget<CupertinoActivityIndicator, Widget> {
  final double height;
  final double progress;
  PlatformCircularProgressIndicator({
    this.height,
    this.progress,
    bool forceIos,
    bool forceMaterial,
  }) : super(forceIos: forceIos, forceMaterial: forceMaterial);

  @override
  Widget createAndroidWidget(BuildContext context) {
    return Container(
      height: height,
      width: height,
      child: CircularProgressIndicator(
        value: progress == null ? progress : progress / 100,
      ),
    );
  }

  @override
  CupertinoActivityIndicator createIosWidget(BuildContext context) {
    final double radius = (height == null || height <= 0) ? 10 : height / 2;
    if (progress == null) {
      return CupertinoActivityIndicator(
        radius: radius,
      );
    }
    return CupertinoActivityIndicator.partiallyRevealed(
      progress: progress / 100,
      radius: radius,
    );
  }
}
