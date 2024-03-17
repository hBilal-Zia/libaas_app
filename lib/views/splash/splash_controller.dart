import 'dart:async';

import 'package:get/get.dart';
import 'package:libaas_app/views/onboading_screen/onboarding.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Timer(const Duration(seconds: 4), () {
      Get.to(const OnboardingScreen());
    });
    // Future.delayed(const Duration(seconds: 5), () {
    // });
  }
}
