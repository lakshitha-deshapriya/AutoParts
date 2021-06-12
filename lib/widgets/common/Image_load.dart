import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class ImageLoad extends StatelessWidget {
  final String coverUrl;
  final double borderWidth;
  final double borderRadius;

  ImageLoad({
    @required this.coverUrl,
    this.borderWidth,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasCover = coverUrl != null && coverUrl.isNotEmpty;
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ThemeBorderContainer(
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        darkColor: Colors.white,
        lightColor: Colors.grey,
        child: hasCover
            ? FancyShimmerImage(
                imageUrl: coverUrl,
              )
            : Image.asset(
                'assets/images/default_part.jpg',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
