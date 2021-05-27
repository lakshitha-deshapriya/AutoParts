import 'package:auto_parts/widgets/common/photo_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_lib/widget_lib.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class ImageCarousol extends StatelessWidget {
  final List<String> images;

  const ImageCarousol({@required this.images});

  @override
  Widget build(BuildContext context) {
    return ThemeSwiper(
      builder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return PhotoViewer(images: images, initIndex: index);
                },
              ),
            );
          },
          child: Hero(
            tag: images[index],
            child: FancyShimmerImage(
              imageUrl: images[index],
              boxFit: BoxFit.fitWidth,
            ),
          ),
        );
      },
      itemCount: images.length,
      viewportFraction: 0.9,
      scale: 0.95,
      loop: false,
      activeDarkColor: Color.fromRGBO(29, 153, 255, 1),
      darkColor: CupertinoColors.white,
      activeLightColor: Colors.lightBlueAccent,
      lightColor: Color.fromRGBO(230, 230, 230, 1),
      layout: SwiperLayout.DEFAULT,
    );
  }
}
