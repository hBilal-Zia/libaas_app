import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_screen.dart';

class ResetController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final resetKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  Future forgotPassword(BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController.text);
      String errorMessage =
          "We have sent you email to recover password. please check email";
      var snackbar = SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.green,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Get.offAll(SignInScreen());
    } on FirebaseAuthException catch (err) {
      throw Exception(err.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
