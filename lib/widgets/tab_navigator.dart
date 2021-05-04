import 'package:auto_parts/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_bar_widget/nav_bar_widget.dart';
import 'package:widget_lib/widgets/utils/widget_util.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformNavBarScaffold(
      forceMaterial: Constant.forceMaterial,
      activeColor: WidgetUtil.isDarkMode(context)
          ? CupertinoColors.white
          : CupertinoColors.systemBlue,
      barItems: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.wrench),
          activeIcon: Icon(CupertinoIcons.wrench_fill),
          label: 'Parts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_repair_service_outlined),
          activeIcon: Icon(Icons.home_repair_service),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bookmark),
          activeIcon: Icon(CupertinoIcons.bookmark_fill),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          activeIcon: Icon(CupertinoIcons.settings_solid),
          label: 'Settings',
        ),
      ],
      screens: [
        Center(child: Text('Parts')),
        Center(child: Text('Services')),
        Center(child: Text('Favourites')),
        Center(child: Text('Settings')),
      ],
    );
  }
}
