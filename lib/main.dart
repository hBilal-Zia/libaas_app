import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/firebase_options.dart';
import 'package:libaas_app/views/home_screen/controller/home_controller.dart';
import 'package:libaas_app/views/recommended/select_outfit_screen.dart';
import 'package:libaas_app/views/splash/splash.dart';
import 'package:libaas_app/views/splash/splash_controller.dart';
import 'package:libaas_app/views/recommended/recommend_outfit_screen.dart';
import 'package:libaas_app/views/week_planner/weekly_planner_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
