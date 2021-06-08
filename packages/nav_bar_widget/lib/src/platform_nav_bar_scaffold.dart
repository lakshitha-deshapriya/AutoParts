import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_bar_widget/src/nav_bar_android_scaffold.dart';
import 'package:nav_bar_widget/src/platform_widget.dart';

class PlatformNavBarScaffold
    extends PlatformWidget<CupertinoTabScaffold, Widget> {
  final List<BottomNavigationBarItem> barItems;
  final Map<int, List<dynamic>> screenData;
  final Color activeColor;
  final Color inactiveColor;
  final double iconSize;
  final double elevation;

  PlatformNavBarScaffold({
    @required this.barItems,
    @required this.screenData,
    this.activeColor,
    this.inactiveColor = CupertinoColors.systemGrey,
    this.iconSize = 30.0,
    this.elevation = 8.0,
    bool forceIos,
    bool forceMaterial,
  }) : super(forceIos: forceIos, forceMaterial: forceMaterial);

  final List<GlobalKey<NavigatorState>> navigatorKeys = [];

  validate() {
    assert(this.barItems != null, 'Bar Items cannot be null');
    assert(this.screenData != null, 'Screens cannot be null');
    assert(this.barItems.length == this.screenData.length,
        'Length of Bar items and Screens should match');
  }

  @override
  Widget createAndroidWidget(BuildContext context) {
    validate();

    List<Widget> screens = [];
    screenData.forEach((key, value) {
      screens.add(value[0]);
    });

    return NavBarAndroidScaffold(
      barItems: barItems,
      screens: screens,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      iconSize: iconSize,
      elevation: elevation,
    );
  }

  @override
  CupertinoTabScaffold createIosWidget(BuildContext context) {
    validate();

    int currentIndex = 0;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        items: barItems,
        currentIndex: currentIndex,
        onTap: (index) {
          if (currentIndex == index) {
            GlobalKey<NavigatorState> navigator = screenData[index][1];
            navigator.currentState.popUntil((r) => r.isFirst);
          }
          currentIndex = index;
        },
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          // navigatorKey: screenData[index][1], //TODO: Needs to un comment this when release
          builder: (context) => screenData[index][0],
        );
      },
    );
  }
}
