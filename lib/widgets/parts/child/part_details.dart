import 'package:auto_parts/models/part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class PartDetails extends StatelessWidget {
  final Part part;

  const PartDetails({@required this.part});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: Container(
          child: ThemeText(
            part.name,
          ),
        ),
      ),
    );
  }
}
