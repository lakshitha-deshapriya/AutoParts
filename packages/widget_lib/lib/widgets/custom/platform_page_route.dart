import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformPageRoute {
  final RouteSettings settings;
  final Widget child;
  final bool forceIos;
  final bool forceMaterial;

  PlatformPageRoute({
    @required this.child,
    this.settings,
    this.forceIos = false,
    this.forceMaterial = false,
  });

  Route build() {
    if (forceIos) {
      return CupertinoPageRoute(builder: (_) => child, settings: settings);
    }
    if (forceMaterial) {
      return MaterialPageRoute(builder: (_) => child, settings: settings);
    }

    final bool isIos = Platform.isIOS;
    if (isIos) {
      return CupertinoPageRoute(builder: (_) => child, settings: settings);
    } else {
      return MaterialPageRoute(builder: (_) => child, settings: settings);
    }
  }
}
