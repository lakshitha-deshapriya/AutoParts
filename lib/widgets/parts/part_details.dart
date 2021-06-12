import 'dart:io';

import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/widgets/common/part_favourite_icon.dart';
import 'package:auto_parts/widgets/common/google_map_show.dart';
import 'package:auto_parts/widgets/common/image_carousol.dart';
import 'package:auto_parts/widgets/common/indented_data_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';
import 'package:widget_lib/widgets/utils/widget_util.dart';

class PartDetails extends StatelessWidget {
  final Part part;

  const PartDetails({@required this.part});

  @override
  Widget build(BuildContext context) {
    final List<String> images =
        part.images.map((image) => image.imageUrl).toList();

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: PlatformScaffold(
        appBar: getAppBar(context),
        cupertinoAppBar: getCupertinoNavigationBar(),
        body: SafeArea(
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
                    bottom: width * 0.02,
                  ),
                  child: ThemeText(
                    part.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.048,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: width * 0.02,
                    horizontal: width * 0.05,
                  ),
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
                ...getIndentedData(width),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: width * 0.02,
                    horizontal: width * 0.05,
                  ),
                  child: ThemeText(
                    part.description,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    darkColor: CupertinoColors.systemGrey4,
                    style: TextStyle(
                      fontSize: width * 0.042,
                    ),
                  ),
                ),
                loadGoogleMapWidget(part, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadGoogleMapWidget(Part part, double width) {
    bool showMap = false;
    double latitude;
    double longitude;
    if (part.location != null && part.location.isNotEmpty) {
      showMap = true;
      List<String> location = part.location.split(',');
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
              initialZoom: 15,
            ),
          )
        : Container();
  }

  AppBar getAppBar(BuildContext context) {
    return Platform.isAndroid
        ? AppBar(
            backgroundColor: WidgetUtil.isDarkMode(context)
                ? Colors.transparent
                : Colors.white,
            actions: [
              PartFavouriteIcon(part: part),
            ],
          )
        : null;
  }

  CupertinoNavigationBar getCupertinoNavigationBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Colors.transparent,
            trailing: PartFavouriteIcon(part: part),
          )
        : null;
  }

  List<Widget> getIndentedData(double width) {
    final EdgeInsets padding = EdgeInsets.symmetric(
      vertical: width * 0.02,
      horizontal: width * 0.05,
    );
    return [
      Container(
        padding: padding,
        child: IndentedDataRow(
          first: 'Brand',
          second: part.brand,
          screenWidth: width,
        ),
      ),
      Container(
        padding: padding,
        child: IndentedDataRow(
          first: 'Model',
          second: part.model,
          screenWidth: width,
        ),
      ),
      Container(
        padding: padding,
        child: IndentedDataRow(
          first: 'Year',
          second: part.year,
          screenWidth: width,
        ),
      ),
      Container(
        padding: padding,
        child: IndentedDataRow(
          first: 'Condition',
          second: part.condition,
          screenWidth: width,
        ),
      ),
      Container(
        padding: padding,
        child: IndentedDataRow(
          first: 'Price',
          second: part.cur + ' ' + part.price.toString(),
          screenWidth: width,
        ),
      ),
    ];
  }
}
