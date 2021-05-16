import 'package:auto_parts/models/part.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class PartItem extends StatelessWidget {
  final double width;
  final Part part;

  PartItem({@required this.width, @required this.part});

  getSubString(Part part) {
    String str = part.brand + ', ' + part.model;
    if (part.year.isNotEmpty) {
      str += ' (' + part.year + ')';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.3,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.01,
      ),
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
                child: loadImage(part, width),
              ),
              Container(
                width: width * 0.65,
                padding: EdgeInsets.symmetric(vertical: width * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTitleAndSubtitle(part, width),
                    ThemeText(
                      part.cur + ' ' + part.price.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadImage(Part part, double width) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ThemeBorderContainer(
        borderWidth: width * 0.003,
        borderRadius: width * 0.01,
        darkColor: Colors.white,
        lightColor: Colors.grey,
        child: Image.asset(
          'assets/images/default_part.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getTitleAndSubtitle(Part part, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
}
