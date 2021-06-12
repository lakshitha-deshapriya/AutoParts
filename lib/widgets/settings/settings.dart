import 'package:auto_parts/widgets/common/app_bar_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return PlatformScaffold(
      topPadding: false,
      appBar: AppBar(title: AppBarTittle(title: 'Settings')),
      cupertinoAppBar:
          CupertinoNavigationBar(middle: AppBarTittle(title: 'Settings')),
      body: Center(
        child: ThemeText('Settings'),
      ),
    );
  }
}
