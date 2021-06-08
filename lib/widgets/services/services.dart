import 'package:auto_parts/providers/meta_data_provider.dart';
import 'package:auto_parts/widgets/common/app_bar_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final MetaDataProvider provider = context.read<MetaDataProvider>();

    return PlatformScaffold(
      topPadding: false,
      appBar: AppBar(title: AppBarTittle(title: 'Services')),
      cupertinoAppBar:
          CupertinoNavigationBar(middle: AppBarTittle(title: 'Services')),
      body: Selector<MetaDataProvider, bool>(
        selector: (_, provider) => provider.isInitialized,
        builder: (_, initialized, child) {
          if (!initialized) {
            return Center(
              child: PlatformCircularProgressIndicator(
                height: width * 0.3,
              ),
            );
          }
          return child;
        },
        child: GridView.builder(
          itemCount: provider.serviceCategories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {},
              child: Container(
                child: Stack(
                  children: [
                    Center(
                      child: ThemeText(
                        provider.serviceCategories[index].category,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.08,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width * 0.45,
            childAspectRatio: 1,
            crossAxisSpacing: width * 0.07,
            mainAxisSpacing: width * 0.02,
          ),
        ),
      ),
    );
  }
}
