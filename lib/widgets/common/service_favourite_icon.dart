import 'package:auto_parts/models/service.dart';
import 'package:auto_parts/providers/favourite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ServiceFavouriteIcon extends StatelessWidget {
  final Service service;
  final double iconSize;
  final bool enableAction;
  final bool showInactive;

  ServiceFavouriteIcon({
    this.service,
    this.iconSize = -1,
    this.enableAction = true,
    this.showInactive = true,
  });

  @override
  Widget build(BuildContext context) {
    final FavouriteProvider favouriteProvider =
        context.read<FavouriteProvider>();

    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Selector<FavouriteProvider, Tuple2<bool, String>>(
        selector: (_, provider) =>
            Tuple2(provider.isInitialized, provider.newFavouriteService),
        builder: (_, tuple, child) {
          if ((tuple.item1 && tuple.item2 == service.id) ||
              favouriteProvider.isFavouriteService(service.id)) {
            return Icon(
              Icons.favorite,
              color: CupertinoColors.systemRed,
              size: iconSize == -1 ? width * 0.075 : iconSize,
            );
          } else {
            return child;
          }
        },
        child: showInactive
            ? Icon(
                Icons.favorite_border,
                color: CupertinoColors.systemGrey,
                size: iconSize == -1 ? width * 0.075 : iconSize,
              )
            : Container(),
      ),
      onTap: () {
        if (enableAction) {
          if (favouriteProvider.isFavouriteService(service.id) ||
              favouriteProvider.newFavouriteService == service.id) {
            favouriteProvider.removeFromFavouriteServices(service);
          } else {
            favouriteProvider.addToFavouriteServices(service);
          }
        }
      },
    );
  }
}
