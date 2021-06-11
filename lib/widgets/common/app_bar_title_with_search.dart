import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class AppBarTitleWithSearch extends StatelessWidget {
  final bool withBack;
  final Function(String) onSearchSubmitted;

  AppBarTitleWithSearch({
    @required this.onSearchSubmitted,
    this.withBack = true,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final double searchBarWidth = withBack ? width * 0.74 : width * 0.865;

    final double leftPadding = withBack ? 0 : width * 0.01;

    return Row(
      children: [
        Container(
          height: width * 0.08,
          width: searchBarWidth,
          padding: EdgeInsets.only(left: leftPadding),
          child: SearchBar(
            screenWidth: width,
            onSubmitted: onSearchSubmitted,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(
              left: width * 0.019,
              bottom: width * 0.007,
            ),
            child: Icon(
              CupertinoIcons.slider_horizontal_3,
              size: width * 0.075,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
      ],
    );
  }
}
