import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class IndentedDataRow extends StatelessWidget {
  final String first;
  final String second;
  final double screenWidth;
  const IndentedDataRow({this.first, this.second, this.screenWidth});

  @override
  Widget build(BuildContext context) {
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
