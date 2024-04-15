import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/views/home_screen/nav_bar.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  final signinKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  void signInUser(BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: pwController.text);
      String errorMessage = "User login successfully!!";
      var snackbar = SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.green,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Get.offAll(const NavBar());
      emailController.clear();
      pwController.clear();
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'invalid-credential') {
        errorMessage = "User not exist";
        var snackbar = SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        errorMessage = "Other exception";
        var snackbar = SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }
}
