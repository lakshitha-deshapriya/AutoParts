import 'package:flutter/material.dart';

class NavBarAndroidScaffold extends StatefulWidget {
  final List<BottomNavigationBarItem> barItems;
  final List<Widget> screens;
  final Color activeColor;
  final Color inactiveColor;
  final double iconSize;

  NavBarAndroidScaffold({
    @required this.barItems,
    @required this.screens,
    this.activeColor,
    this.inactiveColor,
    this.iconSize = 30.0,
  });
  @override
  _NavBarAndroidScaffoldState createState() => _NavBarAndroidScaffoldState();
}

class _NavBarAndroidScaffoldState extends State<NavBarAndroidScaffold> {
  int _currentIndex = 0;
  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      body: widget.screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: widget.iconSize,
        selectedItemColor: widget.activeColor,
        unselectedItemColor: widget.inactiveColor,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: widget.barItems,
      ),
    );
  }
}
