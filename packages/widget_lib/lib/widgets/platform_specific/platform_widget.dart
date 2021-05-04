import 'package:flutter/material.dart';
import 'dart:io' show Platform;

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  final bool forceMaterial;
  final bool forceIos;

  PlatformWidget({
    this.forceMaterial = false,
    this.forceIos = false,
  });
  
  @override
  Widget build(BuildContext context) {
    if (forceIos != null && forceIos) {
      return createIosWidget(context);
    }
    if (forceMaterial != null && forceMaterial) {
      return createAndroidWidget(context);
    }

    if (Platform.isAndroid) {
      return createAndroidWidget(context);
    } else if (Platform.isIOS) {
      return createIosWidget(context);
    }
    return new Container();
  }

  I createIosWidget(BuildContext context);

  A createAndroidWidget(BuildContext context);
}
