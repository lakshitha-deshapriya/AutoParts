import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/widgets/favourites/favourites.dart';
import 'package:auto_parts/widgets/parts/parts_widget.dart';
import 'package:auto_parts/widgets/services/services.dart';
import 'package:auto_parts/widgets/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_bar_widget/nav_bar_widget.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformNavBarScaffold(
      forceMaterial: Constant.forceMaterial,
      activeColor: Color.fromRGBO(29, 153, 255, 1),
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
        PartsWidget(),
        Services(),
        Favourites(),
        Settings(),
      ],
    );
  }
}
