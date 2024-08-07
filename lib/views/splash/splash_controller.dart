import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:libaas_app/views/auth/name_screen/name_screen.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_screen.dart';
import 'package:libaas_app/views/auth/signup_screen/term_condition.dart';
import 'package:libaas_app/views/auth/verify_email/verify_email.dart';
import 'package:libaas_app/views/home_screen/nav_bar.dart';
import 'package:libaas_app/views/onboading_screen/onboarding.dart';
import 'package:libaas_app/views/profile/profile_screen.dart';
import 'package:libaas_app/views/recommended/select_outfit_screen.dart';
import 'package:libaas_app/views/splash/splash.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 10), () {
      if (auth.currentUser != null) {
        Get.offAll(const NavBar());
        // Get.to(SelectOutFitScreen(
        //   bottomId: '',
        //   bottomWear:
        //       'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
        //   footId: '',
        //   footWear:
        //       'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
        //   topId: '',
        //   topWear:
        //       'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
        // ));
      } else {
        Get.to(const OnboardingScreen());
      }
    });
  }
}
