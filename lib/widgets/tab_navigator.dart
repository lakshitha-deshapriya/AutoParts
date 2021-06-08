import 'dart:developer';

import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/providers/favourite_provider.dart';
import 'package:auto_parts/providers/meta_data_provider.dart';
import 'package:auto_parts/providers/parts_provider.dart';
import 'package:auto_parts/providers/service_provider.dart';
import 'package:auto_parts/widgets/parts/parts_widget.dart';
import 'package:auto_parts/widgets/services/services.dart';
import 'package:auto_parts/widgets/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_bar_widget/nav_bar_widget.dart';
import 'package:provider/provider.dart';

class TabNavigator extends StatelessWidget {
  //Initialize initial data
  void initData(BuildContext context) {
    context.read<PartsProvider>().init();
    context.read<FavouriteProvider>().init();
    context.read<ServiceProvider>().init();
    context.read<MetaDataProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    initData(context);

    return PlatformNavBarScaffold(
      forceMaterial: Constant.forceMaterial,
      activeColor: Color.fromRGBO(29, 153, 255, 1),
      elevation: 20,
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
      screenData: {
        0: [PartsWidget(), GlobalKey<NavigatorState>()],
        1: [Services(), GlobalKey<NavigatorState>()],
        2: [Service(), GlobalKey<NavigatorState>()],
        3: [Settings(), GlobalKey<NavigatorState>()],
      },
    );
  }
}
