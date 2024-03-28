import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  final signupKey = GlobalKey<FormState>();
  RxBool isTick = false.obs;
  List<String> gender = ['Male', 'Female'];
  RxString genderSelected = 'Male'.obs;
}
