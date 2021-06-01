import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/providers/favourite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class FavouriteIcon extends StatelessWidget {
  final Part part;
  const FavouriteIcon({this.part});

  @override
  Widget build(BuildContext context) {
    final FavouriteProvider favouriteProvider =
        context.read<FavouriteProvider>();

    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Selector<FavouriteProvider, Tuple2<bool, String>>(
        selector: (_, provider) =>
            Tuple2(provider.isInitialized, provider.newFavouriteId),
        builder: (_, tuple, child) {
          if ((tuple.item1 && tuple.item2 == part.id) ||
              favouriteProvider.isFavourite(part.id)) {
            return Icon(
              Icons.favorite,
              color: CupertinoColors.systemRed,
              size: width * 0.075,
            );
          } else {
            return child;
          }
        },
        child: Icon(
          Icons.favorite_border,
          color: CupertinoColors.systemGrey,
          size: width * 0.075,
        ),
      ),
      onTap: () {
        if (favouriteProvider.isFavourite(part.id) ||
            favouriteProvider.newFavouriteId == part.id) {
          favouriteProvider.removeFromFavourites(part);
        } else {
          favouriteProvider.addToFavourites(part);
        }
      },
    );
  }
}
