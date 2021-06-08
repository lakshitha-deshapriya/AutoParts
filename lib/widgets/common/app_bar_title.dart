import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class AppBarTittle extends StatelessWidget {
  final String title;
  final double size;

  const AppBarTittle({@required this.title, this.size = -1});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return ThemeText(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: size == -1 ? width * 0.05 : size,
      ),
    );
  }
}
