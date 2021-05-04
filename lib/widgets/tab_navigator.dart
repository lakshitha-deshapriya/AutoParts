import 'package:auto_parts/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_bar_widget/nav_bar_widget.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformNavBarScaffold(
      forceMaterial: Constant.forceMaterial,
      barItems: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble_2_fill),
          label: 'Parts test',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bookmark_fill),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.rectangle_grid_2x2_fill),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings_solid),
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
