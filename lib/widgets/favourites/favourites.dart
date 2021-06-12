import 'package:auto_parts/utils/navigation_util.dart';
import 'package:auto_parts/widgets/common/app_bar_title.dart';
import 'package:auto_parts/widgets/favourites/favourite_parts.dart';
import 'package:auto_parts/widgets/favourites/favourite_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widget_lib.dart';

class Favourites extends StatelessWidget {
  const Favourites();

  navigate(BuildContext context, Widget widget) {
    NavigationUtil.navigatePush(context, widget);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final Map<int, List<dynamic>> categoryData = {
      0: ['Parts', FavouriteParts(), 'assets/images/parts.png', 0.9],
      1: ['Services', FavouriteServices(), 'assets/images/services.png', 0.8],
    };

    return PlatformScaffold(
      topPadding: false,
      appBar: AppBar(title: AppBarTittle(title: 'Favourites')),
      cupertinoAppBar:
          CupertinoNavigationBar(middle: AppBarTittle(title: 'Favourites')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.06,
          horizontal: width * 0.06,
        ),
        child: GridView.builder(
          itemCount: categoryData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => navigate(context, categoryData[index][1]),
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
                          Image.asset(
                            categoryData[index][2],
                            fit: BoxFit.cover,
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
                        categoryData[index][0],
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
    );
  }

  Widget appBarTitle(double width) {
    return ThemeText(
      'Favourites',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: width * 0.05,
      ),
    );
  }
}
