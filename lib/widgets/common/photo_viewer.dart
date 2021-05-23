import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:widget_lib/widget_lib.dart';

class PhotoViewer extends StatefulWidget {
  final List<String> images;
  final int initIndex;

  const PhotoViewer({@required this.images, @required this.initIndex});

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  final TransformationController _transformationController =
      TransformationController();
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      cupertinoAppBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
      ),
      body: Dismissible(
        direction: DismissDirection.vertical,
        dismissThresholds: {
          DismissDirection.down: 0.2,
          DismissDirection.up: 0.2,
        },
        key: Key(widget.images[widget.initIndex]),
        onDismissed: (direction) => Navigator.of(context).pop(),
        child: Hero(
          tag: widget.images[widget.initIndex],
          child: Swiper(
            index: widget.initIndex,
            itemBuilder: (BuildContext context, int index) {
              return InteractiveViewer(
                transformationController: _transformationController,
                onInteractionEnd: (details) {
                  _transformationController.value = Matrix4.identity();
                },
                child: FancyShimmerImage(
                  imageUrl: widget.images[index],
                  boxFit: BoxFit.fitWidth,
                ),
              );
            },
            itemCount: widget.images.length,
            loop: false,
            layout: SwiperLayout.DEFAULT,
          ),
        ),
      ),
    );
  }
}
