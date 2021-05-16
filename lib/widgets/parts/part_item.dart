import 'package:auto_parts/models/part.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class PartItem extends StatelessWidget {
  final double width;
  final Part part;

  PartItem({@required this.width, @required this.part});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width * 0.3,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.01,
      ),
      child: ThemeCard(
        darkColor: Colors.grey.withOpacity(0.2),
        lightColor: Color.fromRGBO(237, 237, 237, 1),
        borderRadius: width * 0.04,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
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
              ),
            ),
            Text(part.name),
          ],
        ),
      ),
    );
  }
}
