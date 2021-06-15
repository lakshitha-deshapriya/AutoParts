import 'package:auto_parts/providers/favourite_provider.dart';
import 'package:auto_parts/widgets/common/app_bar_title_with_search.dart';
import 'package:auto_parts/widgets/common/custom_progress_indicator.dart';
import 'package:auto_parts/widgets/parts/part_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:widget_lib/widget_lib.dart';

class FavouriteParts extends StatefulWidget {
  @override
  _FavouritePartsState createState() => _FavouritePartsState();
}

class _FavouritePartsState extends State<FavouriteParts> {
  FavouriteProvider favouriteProvider;

  onSearchTextSubmitted(String searchText) {
    favouriteProvider.filterDataForPartSearch(searchText);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    favouriteProvider = context.read<FavouriteProvider>();

    return PlatformScaffold(
      topPadding: false,
      appBar: AppBar(
        title: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      cupertinoAppBar: CupertinoNavigationBar(
        middle: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      body: Selector<FavouriteProvider, Tuple2<bool, String>>(
        selector: (_, provider) =>
            Tuple2(provider.isInitialized, provider.newFavouritePart),
        builder: (_, tuple, __) {
          if (tuple.item1) {
            if (favouriteProvider.filteredFavouriteParts.isEmpty) {
              return Center(
                child: ThemeText(
                  'No Favourite Parts',
                  style: TextStyle(
                    fontSize: width * 0.055,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                top: width * 0.01,
                bottom: width * 0.01,
              ),
              child: ListView.builder(
                itemCount: favouriteProvider.filteredFavouriteParts.length,
                itemBuilder: (context, index) {
                  return PartItem(
                    width: width,
                    part: favouriteProvider.filteredFavouriteParts[index],
                    showDate: false,
                    enableFavouriteAction: true,
                  );
                },
              ),
            );
          } else {
            return CustomProgressIndicator();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    favouriteProvider.resetData();
    super.dispose();
  }
}
