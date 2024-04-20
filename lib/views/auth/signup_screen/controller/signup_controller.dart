import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/model/user_model.dart';
import 'package:libaas_app/views/auth/verify_email/verify_email.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController dayController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final signupKey = GlobalKey<FormState>();
  RxBool isTick = false.obs;
  List<String> gender = ['Male', 'Female'];
  RxString genderSelected = 'Male'.obs;

  void signUpUser(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: pwController.text,
      );
      debugPrint('lll');
      final user = _auth.currentUser;
      debugPrint(user!.uid);
      await addUser(
          UserModel(
            userId: user.uid,
            dateofBirth: dayController.text,
            fullName: nameController.text,
            email: emailController.text,
            gender: genderSelected.value,
          ),
          context);

      debugPrint('fff');
      emailController.clear();
      pwController.clear();
      nameController.clear();
      dayController.clear();

      genderSelected.value = 'Male';
      update();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        String errorCode = "Email already in use";

        var snackbar = SnackBar(
          content: Text(errorCode),
          backgroundColor: Colors.red,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackbar);

        update();
      } else {
        String errorCode = "An error occurred during signup";
        var snackbar = SnackBar(
          content: Text(errorCode),
          backgroundColor: Colors.red,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  Future<void> addUser(UserModel userdata, BuildContext context) async {
    final datauser = FirebaseFirestore.instance.collection('user');
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final user = auth.currentUser;
      if (user != null) {
        String code = "User signup successfully!!";
        var snackbar = SnackBar(
          content: Text(code),
          backgroundColor: Colors.green,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        await datauser.doc(user.uid).set(userdata.toMap());
        debugPrint('ddddd');
        Get.offAll(const VerifyEmailScreen());
      }
    } catch (e) {
      debugPrint('Error adding item: $e');
    }
  }

  // Future<String> resendVerifyEmail(String email) async {
  //   try {
  //     user!.sendEmailVerification();
  //     return user?.uid;
  //   } catch (e) {
  //     print("An Error occurred while sending verification link");
  //     print(e.toString());
  //     return null;
  //   }
  //  }
}
