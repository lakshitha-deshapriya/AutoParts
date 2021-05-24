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
    return PlatformScaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.35,
            child: ImageCarousol(images: images),
          ),
        ],
      ),
    );
  }
}
