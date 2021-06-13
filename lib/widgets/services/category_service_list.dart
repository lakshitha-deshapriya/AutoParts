import 'dart:async';

import 'package:auto_parts/models/service.dart';
import 'package:auto_parts/providers/service_provider.dart';
import 'package:auto_parts/widgets/common/app_bar_title_with_search.dart';
import 'package:auto_parts/widgets/common/custom_progress_indicator.dart';
import 'package:auto_parts/widgets/services/service_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';

class CategoryServiceList extends StatefulWidget {
  final int categoryId;

  CategoryServiceList({@required this.categoryId});

  @override
  _CategoryServiceListState createState() => _CategoryServiceListState();
}

class _CategoryServiceListState extends State<CategoryServiceList> {
  StreamController streamController;
  @override
  Widget build(BuildContext context) {
    final ServiceProvider serviceProvider = context.read<ServiceProvider>();
    serviceProvider.initForCategory(widget.categoryId);

    streamController = StreamController<List<Service>>();

    final double width = MediaQuery.of(context).size.width;

    return PlatformScaffold(
      topPadding: false,
      appBar: AppBar(
        title: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      cupertinoAppBar: CupertinoNavigationBar(
        middle: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is UserScrollNotification) {
            if ((scrollInfo).direction == ScrollDirection.reverse &&
                scrollInfo.metrics.maxScrollExtent ==
                    scrollInfo.metrics.pixels) {
              serviceProvider.getNextPage(
                streamController,
                widget.categoryId,
              );
            }
          }
          return true;
        },
        child: Selector<ServiceProvider, String>(
          selector: (_, provider) => provider.initializedCategoryKey,
          builder: (_, initCategoryKey, child) {
            if (initCategoryKey.isNotEmpty &&
                serviceProvider.isCategoryInitialized(widget.categoryId)) {
              serviceProvider.addDataToStream(
                streamController,
                widget.categoryId,
              );
              if (!serviceProvider.hasDataForCategory(widget.categoryId)) {
                return Center(
                  child: ThemeText(
                    'No Services for category',
                    style: TextStyle(
                      fontSize: width * 0.055,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }
              return child;
            } else {
              return CustomProgressIndicator();
            }
          },
          child: StreamBuilder<List<Service>>(
            stream: streamController.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Service>> snapshot) {
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
                        return ServiceItem(
                          width: width,
                          service: snapshot.data[index],
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

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  onSearchTextSubmitted(String searchText) {
    print(searchText);
  }
}
