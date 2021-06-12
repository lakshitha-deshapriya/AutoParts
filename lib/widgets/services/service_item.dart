import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/models/service.dart';
import 'package:auto_parts/models/service_category.dart';
import 'package:auto_parts/providers/meta_data_provider.dart';
import 'package:auto_parts/widgets/common/favourite_icon.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';

class ServiceItem extends StatelessWidget {
  final double width;
  final Service service;
  final bool showDate;
  final bool enableFavouriteAction;

  ServiceItem({
    @required this.width,
    @required this.service,
    this.showDate = true,
    this.enableFavouriteAction = false,
  });

  navigate(BuildContext context) {
    // NavigationUtil.navigatePush(context, PartDetails(part: part));
  }

  @override
  Widget build(BuildContext context) {
    final MetaDataProvider metaData = context.read<MetaDataProvider>();
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
                  child: loadImage(service, width),
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
                      getTitleAndCategories(service, width, metaData),
                      Text(''), //Needs to add the organization name
                      getPriceAndPostedDate(service, showDate),
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

  Widget loadImage(Service service, double width) {
    bool hasCover = service.coverUrl.isNotEmpty;
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ThemeBorderContainer(
        borderWidth: width * 0.003,
        borderRadius: width * 0.01,
        darkColor: Colors.white,
        lightColor: Colors.grey,
        child: hasCover
            ? FancyShimmerImage(
                imageUrl: service.coverUrl,
              )
            : Image.asset(
                'assets/images/default_part.jpg',
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget getTitleAndCategories(
      Service service, double width, MetaDataProvider metaData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ThemeText(
              service.name,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            // FavouriteIcon(
            //   part: part,
            //   iconSize: width * 0.055,
            //   enableAction: enableFavouriteAction,
            //   showInactive: false,
            // ),
          ],
        ),
        SizedBox(
          height: width * 0.01,
        ),
        ThemeText(
          getCategories(metaData, service.categories),
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

  getCategories(MetaDataProvider metaData, List<int> categories) {
    return metaData.serviceCategories
        .where((category) => categories.contains(category.id))
        .map((category) => category.category)
        .join(', ');
  }

  getPriceAndPostedDate(Service service, bool showDate) {
    final int days = DateTime.now().difference(service.modified).inDays;
    String time = '';
    if (days == 0) {
      time = DateTime.now().difference(service.modified).inHours.toString() +
          ' hours';
    } else if (days == 1) {
      time = 'yesterday';
    } else {
      time = days.toString() + ' days';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(), //TODO: Add the place
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
