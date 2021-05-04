import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_bar_widget/src/nav_bar_android_scaffold.dart';
import 'package:nav_bar_widget/src/platform_widget.dart';

class PlatformNavBarScaffold
    extends PlatformWidget<CupertinoTabScaffold, Widget> {
  final List<BottomNavigationBarItem> barItems;
  final List<Widget> screens;
  final Color activeColor;
  final Color inactiveColor;
  final double iconSize;

  PlatformNavBarScaffold({
    @required this.barItems,
    @required this.screens,
    this.activeColor,
    this.inactiveColor = CupertinoColors.systemGrey,
    this.iconSize = 30.0,
    bool forceIos,
    bool forceMaterial,
  }) : super(forceIos: forceIos, forceMaterial: forceMaterial);

  final List<GlobalKey<NavigatorState>> navigatorKeys =
      List<GlobalKey<NavigatorState>>();

  validate() {
    assert(this.barItems != null, 'Bar Items cannot be null');
    assert(this.screens != null, 'Screens cannot be null');
    assert(this.barItems.length == this.screens.length,
        'Length of Bar items and Screens should match');
  }

  generateNavigationKeys(int amount) {
    for (int i = 0; i < amount; i++) {
      navigatorKeys.add(GlobalKey<NavigatorState>());
    }
  }

  @override
  Widget createAndroidWidget(BuildContext context) {
    validate();

    return NavBarAndroidScaffold(
      barItems: barItems,
      screens: screens,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      iconSize: iconSize,
    );
  }

  @override
  CupertinoTabScaffold createIosWidget(BuildContext context) {
    validate();

    generateNavigationKeys(this.barItems.length);

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
            navigatorKeys[index].currentState.popUntil((r) => r.isFirst);
          }
          currentIndex = index;
        },
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          // navigatorKey: navigatorKeys[index], //TODO: Needs to uncomment when release
          builder: (context) => screens[index],
        );
      },
    );
  }
}
