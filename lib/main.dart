import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/notification_service.dart';
import 'package:libaas_app/firebase_options.dart';
import 'package:libaas_app/views/home_screen/controller/home_controller.dart';
import 'package:libaas_app/views/recommended/select_outfit_screen.dart';
import 'package:libaas_app/views/splash/splash.dart';
import 'package:libaas_app/views/splash/splash_controller.dart';
import 'package:libaas_app/views/recommended/recommend_outfit_screen.dart';
import 'package:libaas_app/views/week_planner/weekly_planner_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    },
  );
  await NotificationService.initializeNotification();
  // Request storage permission
  var status = await Permission.storage.request();
  if (!status.isGranted) {
    // Optionally, you can handle the case when permission is not granted
    print('Storage permission denied');
  }
  Get.put(SplashController());
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
