import 'package:auto_parts/models/service.dart';
import 'package:auto_parts/providers/meta_data_provider.dart';
import 'package:auto_parts/utils/navigation_util.dart';
import 'package:auto_parts/widgets/common/Image_load.dart';
import 'package:auto_parts/widgets/common/service_favourite_icon.dart';
import 'package:auto_parts/widgets/services/service_details.dart';
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
    NavigationUtil.navigatePush(context, ServiceDetails(service: service));
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
                  child: ImageLoad(
                    coverUrl: service.coverUrl,
                    borderWidth: width * 0.003,
                    borderRadius: width * 0.01,
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
                      getTitleAndCategories(service, width, metaData),
                      Text(''), //Needs to add the organization name
                      getPostedDateAndLocation(service, showDate),
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
            ServiceFavouriteIcon(
              service: service,
              iconSize: width * 0.055,
              enableAction: true,
              showInactive: true,
            ),
          ],
        ),
        SizedBox(
          height: width * 0.01,
        ),
        ThemeText(
          getCategories(metaData, service),
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

  getCategories(MetaDataProvider metaData, Service service) {
    final List<int> categories =
        service.categories.map((category) => category.category).toList();
    return metaData.serviceCategories
        .where((category) => categories.contains(category.id))
        .map((category) => category.category)
        .join(', ');
  }

  getPostedDateAndLocation(Service service, bool showDate) {
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
