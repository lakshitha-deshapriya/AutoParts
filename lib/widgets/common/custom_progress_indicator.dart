import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Center(
      child: PlatformCircularProgressIndicator(
        height: width * 0.3,
      ),
    );
  }
}
