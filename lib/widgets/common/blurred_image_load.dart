import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class BlurredImageLoad extends StatelessWidget {
  final String imageUrl;
  final String assetImagePath;

  const BlurredImageLoad({
    this.imageUrl,
    this.assetImagePath,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (imageUrl != null) {
      imageWidget = FancyShimmerImage(
        imageUrl: imageUrl,
        boxFit: BoxFit.fitHeight,
      );
    } else {
      imageWidget = Image.asset(
        assetImagePath,
        fit: BoxFit.cover,
      );
    }
    return Stack(
      children: [
        imageWidget,
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              stops: [0.3, 1],
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
