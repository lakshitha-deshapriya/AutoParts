import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class Services extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        CupertinoSliverNavigationBar(
          // automaticallyImplyTitle: false,
          middle: Container(),
          // transitionBetweenRoutes: false,
          // stretch: false,
          // stretch: true,
          automaticallyImplyTitle: false,
          largeTitle: Container(
            height: 35,
            padding: EdgeInsets.only(right: 20),
            child: PlatformTextField(
              radius: 10,
              insidePadding: 10,
              enabled: true,
              textStyle: TextStyle(color: Colors.blueAccent),
              placeHolder: 'Search',
              placeHolderStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                height: 100,
                child: Center(
                    child: Text(
                  'Text',
                  style: TextStyle(color: Colors.white),
                )),
              );
            },
            childCount: 10,
          ),
        )
        // SliverAppBar(
        //   title: Text('Services'),
        // )
      ],
      shrinkWrap: true,
    );
  }
}
