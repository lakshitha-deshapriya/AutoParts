import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/platform_specific/platform_widget.dart';

class PlatformScaffold extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  final AppBar appBar;
  final CupertinoNavigationBar cupertinoAppBar;
  final Widget body;
  final Widget background;
  final Widget bottomNavBar;
  final bool topPadding;
  final String platform;
  final Color backgroundColor;

  PlatformScaffold({
    @required this.body,
    this.appBar,
    this.cupertinoAppBar,
    this.background,
    this.bottomNavBar,
    this.topPadding = true,
    this.platform,
    this.backgroundColor,
    bool forceMaterial,
    bool forceIos,
  }) : super(forceMaterial: forceMaterial, forceIos: forceIos);

  @override
  Scaffold createAndroidWidget(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.only(
            top: topPadding ? MediaQuery.of(context).padding.top : 0),
        child: Stack(
          children: <Widget>[
            background != null
                ? background
                : Container(
                    color: Colors.transparent,
                  ),
            body,
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavBar,
    );
  }

  @override
  CupertinoPageScaffold createIosWidget(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: cupertinoAppBar,
      child: Padding(
        padding: EdgeInsets.only(
            top: topPadding ? MediaQuery.of(context).padding.top : 0),
        child: Stack(
          children: <Widget>[
            background != null
                ? background
                : Container(
                    color: Colors.transparent,
                  ),
            body,
          ],
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
