import 'package:auto_parts/providers/meta_data_provider.dart';
import 'package:auto_parts/utils/navigation_util.dart';
import 'package:auto_parts/widgets/common/app_bar_title.dart';
import 'package:auto_parts/widgets/services/category_service_list.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_lib/widget_lib.dart';

class Services extends StatelessWidget {
  navigate(BuildContext context, int categoryId) {
    NavigationUtil.navigatePush(
      context,
      CategoryServiceList(categoryId: categoryId),
    );
  }

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
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: width * 0.06,
            horizontal: width * 0.06,
          ),
          child: GridView.builder(
            itemCount: provider.serviceCategories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () =>
                    navigate(context, provider.serviceCategories[index].id),
                child: Container(
                  child: Stack(
                    children: [
                      ThemeBorderContainer(
                        borderWidth: width * 0.005,
                        borderRadius: width * 0.05,
                        darkColor: Colors.white,
                        lightColor: Colors.grey,
                        child: Stack(
                          children: [
                            FancyShimmerImage(
                              imageUrl:
                                  provider.serviceCategories[index].coverUrl,
                              boxFit: BoxFit.fitHeight,
                            ),
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
                        ),
                      ),
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
              mainAxisSpacing: width * 0.07,
            ),
          ),
        ),
      ),
    );
  }
}
