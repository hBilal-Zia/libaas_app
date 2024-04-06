import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/views/home_screen/home_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            HomeScreen(),
            Container(color: Colors.red),
            Container(color: Colors.greenAccent.shade700),
            Container(color: Colors.orange),
          ],
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
        ),
        bottomNavigationBar: BottomBar(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedIndex: _currentPage,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
          },
          items: const <BottomBarItem>[
            BottomBarItem(
                icon: Icon(Icons.home_outlined, size: 32),
                title: Text('Home'),
                backgroundColorOpacity: 0.9,
                activeColor: ColorConstraint.primaryColor,
                activeTitleColor: Colors.white,
                inactiveColor: Colors.black,
                activeIconColor: Colors.white),
            BottomBarItem(
                icon: Icon(FontAwesomeIcons.shirt, size: 22),
                title: Text(' Outfit'),
                backgroundColorOpacity: 0.9,
                activeColor: ColorConstraint.primaryColor,
                activeTitleColor: Colors.white,
                inactiveColor: Colors.black,
                activeIconColor: Colors.white),
            BottomBarItem(
                icon: Icon(FontAwesomeIcons.solidBell),
                title: Text('Notification'),
                backgroundColorOpacity: 0.9,
                activeColor: ColorConstraint.primaryColor,
                activeTitleColor: Colors.white,
                inactiveColor: Colors.black,
                activeIconColor: Colors.white),
            BottomBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 30,
                ),
                title: Text('Setting'),
                backgroundColorOpacity: 0.9,
                activeColor: ColorConstraint.primaryColor,
                activeTitleColor: Colors.white,
                inactiveColor: Colors.black,
                activeIconColor: Colors.white),
          ],
        ));
  }
}
