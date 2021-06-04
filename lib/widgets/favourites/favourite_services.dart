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
      appBar: AppBar(title: appBarTitle(width)),
      cupertinoAppBar: CupertinoNavigationBar(middle: appBarTitle(width)),
      body: Center(
        child: ThemeText('No Favourite Services'),
      ),
    );
  }

  onSearchTextSubmitted(String searchText) {
    print(searchText);
  }

  Widget appBarTitle(double width) {
    return Row(
      children: [
        Container(
          height: width * 0.08,
          width: width * 0.74,
          child: SearchBar(
            screenWidth: width,
            onSubmitted: onSearchTextSubmitted,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(
              left: width * 0.019,
              bottom: width * 0.007,
            ),
            child: Icon(
              CupertinoIcons.slider_horizontal_3,
              size: width * 0.075,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
      ],
    );
  }
}
