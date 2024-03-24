import 'dart:async';

import 'package:get/get.dart';
import 'package:libaas_app/views/onboading_screen/onboarding.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 10), () {
      Get.to(const OnboardingScreen());
    });
  }
}
