import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/views/splash/splash.dart';
import 'package:libaas_app/views/splash/splash_controller.dart';

void main() {
  Get.put(SplashController());
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
