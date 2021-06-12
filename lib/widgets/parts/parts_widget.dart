import 'dart:async';

import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/providers/parts_provider.dart';
import 'package:auto_parts/widgets/common/app_bar_title_with_search.dart';
import 'package:auto_parts/widgets/common/custom_progress_indicator.dart';
import 'package:auto_parts/widgets/parts/part_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';

class PartsWidget extends StatefulWidget {
  @override
  _PartsWidgetState createState() => _PartsWidgetState();
}

class _PartsWidgetState extends State<PartsWidget> {
  StreamController streamController;
  double prevScrollPoint = 0;

  @override
  Widget build(BuildContext context) {
    final PartsProvider partsProvider = context.read<PartsProvider>();

    streamController = StreamController<List<Part>>();

    final double width = MediaQuery.of(context).size.width;

    return PlatformScaffold(
      topPadding: false,
      appBar: AppBar(
        title: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      cupertinoAppBar: CupertinoNavigationBar(
        middle: AppBarTitleWithSearch(
          onSearchSubmitted: onSearchTextSubmitted,
          withBack: false,
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is UserScrollNotification) {
            if ((scrollInfo).direction == ScrollDirection.reverse &&
                scrollInfo.metrics.maxScrollExtent ==
                    scrollInfo.metrics.pixels) {
              partsProvider.getNextPage(streamController);
            }
          }
          return true;
        },
        child: Selector<PartsProvider, bool>(
          selector: (_, provider) => provider.isInitialized,
          builder: (_, initialized, child) {
            if (initialized) {
              partsProvider.addDataToStream(streamController);
              return child;
            } else {
              return CustomProgressIndicator();
            }
          },
          child: StreamBuilder<List<Part>>(
            stream: streamController.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Part>> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CustomProgressIndicator();
                default:
                  return Padding(
                    padding: EdgeInsets.only(
                      top: width * 0.01,
                      bottom: width * 0.01,
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return PartItem(
                          width: width,
                          part: snapshot.data[index],
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  onSearchTextSubmitted(String searchText) {
    print(searchText);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
