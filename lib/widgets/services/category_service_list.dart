import 'package:auto_parts/providers/service_provider.dart';
import 'package:auto_parts/widgets/common/app_bar_title_with_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';

class CategoryServiceList extends StatelessWidget {
  final int categoryId;

  CategoryServiceList({@required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final ServiceProvider serviceProvider = context.read<ServiceProvider>();
    serviceProvider.initForCategory(categoryId);

    final double width = MediaQuery.of(context).size.width;

    return PlatformScaffold(
      appBar: AppBar(
        title: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      cupertinoAppBar: CupertinoNavigationBar(
        middle: AppBarTitleWithSearch(onSearchSubmitted: onSearchTextSubmitted),
      ),
      body: Selector<ServiceProvider, bool>(
        selector: (_, provider) => provider.isInitialized,
        builder: (_, initialized, __) {
          if (!initialized) {
            return Center(
              child: PlatformCircularProgressIndicator(
                height: width * 0.3,
              ),
            );
          }
          return Center(
            child: ThemeText(categoryId.toString()),
          );
        },
      ),
    );
  }

  onSearchTextSubmitted(String searchText) {
    print(searchText);
  }
}
