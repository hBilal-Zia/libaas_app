import 'dart:developer';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/views/add_item/add_item_screen.dart';
import 'package:libaas_app/views/auth/setting_screen/setting_screen.dart';
import 'package:libaas_app/views/create_outfit/create_outfit_screen.dart';
import 'package:libaas_app/views/home_screen/home_screen.dart';
import 'package:libaas_app/views/notification_screen/notification_screen.dart';

class NavBar extends StatefulWidget {
  final int initialIndex;

  const NavBar({super.key, this.initialIndex = 0});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentPage = 0;
  final _pageController = PageController();
  final _pageNo = [
    HomeScreen(),
    const CreateOutfitScreen(),
    const AddItemScreen(),
    const NotificationScreen(),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageNo[_currentPage],
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
              backgroundColor: ColorConstraint.primaryColor,
              style: TabStyle.fixedCircle,
              items: const [
                TabItem(
                  icon: Icons.home,
                  title: 'Home',
                ),
                TabItem(icon: FontAwesomeIcons.shirt, title: 'Outfit'),
                TabItem(icon: Icons.add, title: 'Add'),
                TabItem(
                  icon: FontAwesomeIcons.solidBell,
                  title: 'Notification',
                ),
                TabItem(icon: Icons.settings, title: 'Setting'),
              ],
              initialActiveIndex: _currentPage,
              onTap: (int i) {
                setState(() => _currentPage = i);
              }),
        ));
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color, [String? someOtherParameter]) {
    // Handle the optional parameter (if necessary), or just ignore it
    return TextStyle(fontSize: 12, color: color);
  }
}
