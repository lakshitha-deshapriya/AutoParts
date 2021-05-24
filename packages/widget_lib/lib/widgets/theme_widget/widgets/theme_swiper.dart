import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:widget_lib/widgets/theme_widget/theme_widget.dart';

class ThemeSwiper extends ThemeWidget<Widget> {
  final int itemCount;
  final int initialIndex;
  final double viewportFraction;
  final double scale;
  final bool loop;
  final EdgeInsetsGeometry margin;
  final Alignment alignment;
  final Color activeDarkColor;
  final Color activeLightColor;
  final IndexedWidgetBuilder builder;
  final SwiperLayout layout;
  final bool addPagination;

  ThemeSwiper({
    @required this.itemCount,
    this.initialIndex = 0,
    this.viewportFraction = 1.0,
    this.scale = 1.0,
    this.loop = false,
    this.margin,
    this.alignment = Alignment.bottomCenter,
    this.activeDarkColor = Colors.blueGrey,
    this.activeLightColor = Colors.blueGrey,
    @required this.builder,
    this.layout = SwiperLayout.DEFAULT,
    this.addPagination = true,
    bool forceDark,
    Color darkColor = Colors.white,
    Color lightColor = Colors.grey,
  }) : super(
            forceDark: forceDark, darkColor: darkColor, lightColor: lightColor);

  @override
  Widget createDarkWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return Swiper(
      itemBuilder: builder,
      itemCount: itemCount,
      viewportFraction: viewportFraction,
      scale: scale,
      loop: loop,
      pagination: addPagination
          ? SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: activeDarkColor,
                color: darkColor,
              ),
              alignment: alignment,
              margin: margin,
            )
          : null,
      layout: SwiperLayout.DEFAULT,
    );
  }

  @override
  Widget createLightWidget(
      BuildContext context, Color color, bool forceIos, bool forceMaterial) {
    return Swiper(
      itemBuilder: builder,
      itemCount: itemCount,
      viewportFraction: viewportFraction,
      scale: scale,
      loop: loop,
      pagination: addPagination
          ? SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: activeLightColor,
                color: lightColor,
              ),
              alignment: alignment,
              margin: margin,
            )
          : null,
      layout: SwiperLayout.DEFAULT,
    );
  }
}
