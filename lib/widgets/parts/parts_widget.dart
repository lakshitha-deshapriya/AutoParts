import 'dart:async';

import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/providers/parts_provider.dart';
import 'package:auto_parts/widgets/parts/part_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';

class PartsWidget extends StatefulWidget {
  @override
  _PartsWidgetState createState() => _PartsWidgetState();
}

class _PartsWidgetState extends State<PartsWidget> {
  PartsProvider partsProvider;
  StreamController streamController;
  @override
  Widget build(BuildContext context) {
    partsProvider = context.read<PartsProvider>();

    streamController = StreamController<List<Part>>();

    final double width = MediaQuery.of(context).size.width;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification) {}
        if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
          partsProvider.getNextPage(streamController);
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
            return Center(
              child: PlatformCircularProgressIndicator(
                height: width * 0.3,
              ),
            );
          }
        },
        child: StreamBuilder<List<Part>>(
          stream: streamController.stream,
          builder: (BuildContext context, AsyncSnapshot<List<Part>> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: PlatformCircularProgressIndicator(
                    height: width * 0.3,
                  ),
                );
              default:
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PartItem(
                      width: width,
                      part: snapshot.data[index],
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('disposed');
    streamController.close();
    super.dispose();
  }
}
