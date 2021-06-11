import 'package:auto_parts/widgets/common/app_bar_title_with_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class FavouriteServices extends StatelessWidget {
  const FavouriteServices();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return PlatformScaffold(
      topPadding: false,
      appBar: AppBar(
        title: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      cupertinoAppBar: CupertinoNavigationBar(
        middle: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      body: Center(
        child: ThemeText('No Favourite Services'),
      ),
    );
  }

  onSearchTextSubmitted(String searchText) {
    print(searchText);
  }
}
