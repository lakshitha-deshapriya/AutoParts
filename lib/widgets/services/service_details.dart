import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/service.dart';
import 'package:auto_parts/providers/meta_data_provider.dart';
import 'package:auto_parts/widgets/common/google_map_show.dart';
import 'package:auto_parts/widgets/common/image_carousol.dart';
import 'package:auto_parts/widgets/common/service_favourite_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';
import 'package:widget_lib/widgets/utils/widget_util.dart';

class ServiceDetails extends StatelessWidget {
  final Service service;

  const ServiceDetails({@required this.service});

  @override
  Widget build(BuildContext context) {
    final List<String> images =
        service.images.map((image) => image.imageUrl).toList();

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final EdgeInsets padding =
        EdgeInsets.symmetric(vertical: width * 0.02, horizontal: width * 0.05);

    final MetaDataProvider metaData = context.read<MetaDataProvider>();

    return SafeArea(
      child: PlatformScaffold(
        appBar: getAppBar(context),
        cupertinoAppBar: getCupertinoNavigationBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: width * 0.035),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.35,
                    child: ImageCarousol(images: images),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: width * 0.05,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 0,
                    ),
                    child: ThemeText(
                      service.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.048,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: width * 0.01,
                      horizontal: width * 0.05,
                    ),
                    child: ThemeText(
                      getCategories(metaData, service),
                      softWrap: true,
                      darkColor: CupertinoColors.systemGrey4,
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: width * 0.042,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    padding: padding,
                    child: ThemeText(
                      '(TODO: Add the marketer name)',
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      darkColor: CupertinoColors.systemGrey4,
                      style: TextStyle(
                        fontSize: width * 0.042,
                      ),
                    ),
                  ),
                  Container(
                    padding: padding,
                    child: ThemeText(
                      service.description,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      darkColor: CupertinoColors.systemGrey4,
                      style: TextStyle(
                        fontSize: width * 0.042,
                      ),
                    ),
                  ),
                  loadGoogleMapWidget(service, width),
                ],
              ),
            ),
          ),
        ),
      ),
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

  loadGoogleMapWidget(Service service, double width) {
    bool showMap = false;
    double latitude;
    double longitude;
    if (service.location != null && service.location.isNotEmpty) {
      showMap = true;
      List<String> location = service.location.split(',');
      latitude = double.parse(location[0].trim());
      longitude = double.parse(location[1].trim());
    }

    return showMap
        ? Container(
            height: width,
            padding: EdgeInsets.symmetric(
              vertical: width * 0.02,
              horizontal: width * 0.05,
            ),
            child: GoogleMapShow(
              latitude: latitude,
              longitude: longitude,
              initialZoom: Constant.initialZoom,
            ),
          )
        : Container();
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          WidgetUtil.isDarkMode(context) ? Colors.transparent : Colors.white,
      actions: [
        ServiceFavouriteIcon(service: service),
      ],
    );
  }

  CupertinoNavigationBar getCupertinoNavigationBar() {
    return CupertinoNavigationBar(
      backgroundColor: Colors.transparent,
      trailing: ServiceFavouriteIcon(service: service),
    );
  }
}
