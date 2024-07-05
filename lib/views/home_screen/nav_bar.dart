import 'dart:developer';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    AddItemScreen(),
    const NotificationScreen(),
    const SettingScreen()
  ];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    fetchFirestoreData();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> fetchFirestoreData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('weekplanner')
          .where('outfitUserId', isEqualTo: _auth.currentUser!.uid)
          .get();

      // Process documents and schedule notifications
      // Process documents and schedule notifications
      final currentTime = DateTime.now();
      final DateFormat dateFormat = DateFormat('MM/dd/yyyy hh:mm a');

      for (var doc in querySnapshot.docs) {
        String dateString =
            doc['date']; // Assuming 'date' is the key for the date string
        DateTime date = dateFormat.parse(dateString);

        // Compare document timestamp with current time
        if (date.isBefore(currentTime)) {
          // Document is outdated, delete it
          await FirebaseFirestore.instance
              .collection('weekplanner')
              .doc(doc.id)
              .delete();
        }
        // Calculate notification time 2 hours before 'date'
        DateTime notificationTime = date.subtract(const Duration(hours: 2));

        if (currentTime.year == date.year &&
            currentTime.month == date.month &&
            currentTime.day == date.day &&
            currentTime.isBefore(date) &&
            notificationTime.difference(currentTime).inHours <= 2) {
          // Schedule notification
          log(notificationTime.toString());
          flutterLocalNotificationsPlugin.show(
              doc.id.hashCode,
              "Outfit Reminder!!",
              "You have a outfit today to wear from week planner at ${doc['dateDay']} ${doc['time']}",
              const NotificationDetails(
                  android: AndroidNotificationDetails('jjj', 'kkkk',
                      channelDescription: 'kklll',
                      styleInformation: BigTextStyleInformation(''),
                      importance: Importance.high,
                      color: Colors.blue,
                      playSound: true,
                      icon: '@mipmap/ic_launcher'),
                  iOS: DarwinNotificationDetails(
                      presentSound: true,
                      presentAlert: true,
                      presentBadge: true)),
              payload: 'Open from Local Notification');
        }
      }
    } catch (e) {
      print('Error fetching Firestore data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageNo[_currentPage],
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: ColorConstraint.primaryColor,
            style: TabStyle.fixedCircle,
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: FontAwesomeIcons.shirt, title: 'Outfit'),
              TabItem(icon: Icons.add, title: 'Add'),
              TabItem(icon: FontAwesomeIcons.solidBell, title: 'Notification'),
              TabItem(icon: Icons.settings, title: 'Setting'),
            ],
            initialActiveIndex: _currentPage,
            onTap: (int i) {
              setState(() => _currentPage = i);
            }));
  }
}
