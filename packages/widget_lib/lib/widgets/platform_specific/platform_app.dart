import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_lib/widgets/platform_specific/platform_widget.dart';

class PlatformApp extends PlatformWidget<CupertinoApp, MaterialApp> {
  final Widget home;
  final String title;
  final bool showBanner;
  final RouteFactory generatedRoutes;
  final Map<String, WidgetBuilder> routesList;
  final String initialRoute;

  PlatformApp({
    this.home,
    @required this.title,
    this.showBanner = false,
    this.routesList,
    this.generatedRoutes,
    this.initialRoute,
    bool forceMaterial,
    bool forceIos,
  }) : super(forceMaterial: forceMaterial, forceIos: forceIos);

  @override
  MaterialApp createAndroidWidget(BuildContext context) {
    return MaterialApp(
      builder: (context, childData) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: childData,
        );
      },
      title: title,
      debugShowCheckedModeBanner: showBanner,
      home: home,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Typography.whiteCupertino,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Typography.blackCupertino,
      ),
      onGenerateRoute: generatedRoutes,
      initialRoute: initialRoute,
      routes: routesList,
    );
  }

  @override
  CupertinoApp createIosWidget(BuildContext context) {
    return CupertinoApp(
      builder: (context, childData) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: childData,
        );
      },
      title: title,
      debugShowCheckedModeBanner: showBanner,
      home: home,
      initialRoute: initialRoute,
      onGenerateRoute: generatedRoutes,
      routes: routesList,
      // theme: CupertinoThemeData(
      //   textTheme: CupertinoTextThemeData(
      //     textStyle: TextStyle(
      //       color: darkMode ? CupertinoColors.white : CupertinoColors.black,
      //     ),
      //   ),
      // ),
    );
  }
}
