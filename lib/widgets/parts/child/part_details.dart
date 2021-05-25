import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/widgets/common/image_carousol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class PartDetails extends StatelessWidget {
  final Part part;

  const PartDetails({@required this.part});

  @override
  Widget build(BuildContext context) {
    final List<String> images = part.images;

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return PlatformScaffold(
      body: SingleChildScrollView(
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
              child: getIndentedData('Brand', part.brand, width),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: width * 0.02,
                horizontal: width * 0.05,
              ),
              child: getIndentedData('Model', part.model, width),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: width * 0.02,
                horizontal: width * 0.05,
              ),
              child: getIndentedData('Year', part.year, width),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: width * 0.02,
                horizontal: width * 0.05,
              ),
              child: getIndentedData('Condition', part.condition, width),
            ),
          ],
        ),
      ),
    );
  }

  getIndentedData(String first, String second, double screenWidth) {
    return Row(
      children: [
        Container(
          width: screenWidth * 0.225,
          child: ThemeText(
            first,
            darkColor: Color.fromRGBO(130, 130, 130, 1),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.042,
            ),
          ),
        ),
        ThemeText(
          ':   ' + second,
          softWrap: false,
          overflow: TextOverflow.fade,
          darkColor: Color.fromRGBO(230, 230, 230, 1),
          style: TextStyle(
            fontSize: screenWidth * 0.042,
          ),
        ),
      ],
    );
  }
}
