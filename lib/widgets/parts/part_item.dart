import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/utils/navigation_util.dart';
import 'package:auto_parts/widgets/common/Image_load.dart';
import 'package:auto_parts/widgets/common/part_favourite_icon.dart';
import 'package:auto_parts/widgets/parts/part_details.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class PartItem extends StatelessWidget {
  final double width;
  final Part part;
  final bool showDate;
  final bool enableFavouriteAction;

  PartItem({
    @required this.width,
    @required this.part,
    this.showDate = true,
    this.enableFavouriteAction = false,
  });

  getSubString(Part part) {
    String str = part.brand + ', ' + part.model;
    if (part.year.isNotEmpty) {
      str += ' (' + part.year + ')';
    }
    return str;
  }

  navigate(BuildContext context) {
    NavigationUtil.navigatePush(context, PartDetails(part: part));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.3,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.01,
      ),
      child: GestureDetector(
        onTap: () => navigate(context),
        child: ThemeCard(
          darkColor: Colors.grey.withOpacity(0.2),
          lightColor: Color.fromRGBO(245, 245, 245, 1),
          borderRadius: width * 0.04,
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: width * 0.02),
            child: Row(
              children: [
                Container(
                  width: width * 0.3,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: ImageLoad(
                    coverUrl: part.coverUrl,
                    borderRadius: width * 0.01,
                    borderWidth: width * 0.003,
                  ),
                ),
                Container(
                  width: width * 0.65,
                  padding: EdgeInsets.only(
                    right: width * 0.01,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitleAndSubtitle(part, width),
                      Text(''), //Needs to add the organization name
                      getPriceAndPostedDate(part, showDate),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitleAndSubtitle(Part part, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ThemeText(
              part.name,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            PartFavouriteIcon(
              part: part,
              iconSize: width * 0.055,
              enableAction: enableFavouriteAction,
              showInactive: false,
            ),
          ],
        ),
        ThemeText(
          getSubString(part),
          softWrap: false,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: Colors.grey,
            fontSize: width * 0.038,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  getPriceAndPostedDate(Part part, bool showDate) {
    final int days = DateTime.now().difference(part.modified).inDays;
    String time = '';
    if (days == 0) {
      time = DateTime.now().difference(part.modified).inHours.toString() +
          ' hours';
    } else if (days == 1) {
      time = 'yesterday';
    } else {
      time = days.toString() + ' days';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ThemeText(
          part.cur + ' ' + part.price.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Visibility(
          visible: showDate,
          child: ThemeText(
            time,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
