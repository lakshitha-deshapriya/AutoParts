import 'package:auto_parts/providers/favourite_provider.dart';
import 'package:auto_parts/widgets/parts/part_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:widget_lib/widget_lib.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final FavouriteProvider favouriteProvider =
        context.read<FavouriteProvider>();

    return PlatformScaffold(
      topPadding: false,
      appBar: AppBar(title: appBarTitle(width)),
      cupertinoAppBar: CupertinoNavigationBar(middle: appBarTitle(width)),
      body: Selector<FavouriteProvider, Tuple2<bool, String>>(
        selector: (_, provider) =>
            Tuple2(provider.isInitialized, provider.newFavouriteId),
        builder: (_, tuple, __) {
          if (tuple.item1) {
            return Padding(
              padding: EdgeInsets.only(
                top: width * 0.01,
                bottom: width * 0.01,
              ),
              child: ListView.builder(
                itemCount: favouriteProvider.favourites.length,
                itemBuilder: (context, index) {
                  return PartItem(
                    width: width,
                    part: favouriteProvider.favourites[index],
                    showDate: false,
                  );
                },
              ),
            );
          } else {
            return Center(
              child: PlatformCircularProgressIndicator(
                height: width * 0.3,
              ),
            );
          }
        },
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
          width: width * 0.865,
          padding: EdgeInsets.only(left: width * 0.01),
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
