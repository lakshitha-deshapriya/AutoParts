import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/theme_widget/widgets/theme_text_filed.dart';

class SearchBar extends StatelessWidget {
  final double screenWidth;
  final TextEditingController controller;

  const SearchBar({@required this.screenWidth, this.controller});

  @override
  Widget build(BuildContext context) {
    return ThemeTextField(
      controller: controller,
      radius: screenWidth * 0.02,
      insidePadding: screenWidth * 0.01,
      enableBorder: false,
      placeHolder: 'Search',
      lightPlaceHolderStyle: TextStyle(
        color: CupertinoColors.systemGrey,
        fontWeight: FontWeight.w400,
      ),
      darkPlaceHolderStyle: TextStyle(
        color: CupertinoColors.systemGrey,
        fontWeight: FontWeight.w400,
      ),
      darkFllColor: Colors.grey.withOpacity(0.2),
      lightFillColor: Color.fromRGBO(230, 230, 230, 1),
      lightTextStyle: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
      darkTextStyle: TextStyle(
        color: CupertinoColors.white,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.015),
        child: Icon(
          CupertinoIcons.search,
          size: screenWidth * 0.055,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
