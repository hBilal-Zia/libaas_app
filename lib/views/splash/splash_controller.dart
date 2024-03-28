import 'dart:async';

import 'package:get/get.dart';
import 'package:libaas_app/views/auth/name_screen/name_screen.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_screen.dart';
import 'package:libaas_app/views/auth/signup_screen/term_condition.dart';
import 'package:libaas_app/views/auth/verify_email/verify_email.dart';
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
