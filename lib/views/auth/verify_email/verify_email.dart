import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/views/auth/name_screen/name_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool? isSend = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spaces.large,
                    Spaces.large,
                    textGlobalWidget(
                        text: 'Check your inbox!',
                        fontSize: 33.0,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.black),
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    GestureDetector(
                      onTap: () {
                        auth.currentUser!.sendEmailVerification();
                        isSend = true;
                        String code = "Email has been sended";
                        var snackbar = SnackBar(
                          content: Text(code),
                          backgroundColor: Colors.green,
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F0F0),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: textGlobalWidget(
                            text: isSend == true
                                ? 'Check your mail'
                                : 'Send email for verify',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black),
                      ),
                    ),
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    ButtonComponent(
                      text: 'Next',
                      fontSize: 24,
                      onTap: () async {
                        // Reload the user to get the updated email verification status
                        await auth.currentUser!.reload();
                        if (auth.currentUser!.emailVerified) {
                          String code = "Email verified successfully!!";
                          var snackbar = SnackBar(
                            content: Text(code),
                            backgroundColor: Colors.green,
                          );
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          Get.offAll(NameScreen());
                        } else {
                          String code = "Email is not verified yet";
                          var snackbar = SnackBar(
                            content: Text(code),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackbar,
                          );
                        }
                      },
                    ),
                    // StreamBuilder<User?>(
                    //   stream: FirebaseAuth.instance.userChanges(),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<User?> snapshot) {
                    //     return ButtonComponent(
                    //         text: 'Next',
                    //         fontSize: 24,
                    //         onTap: () {
                    //           if (snapshot.data!.emailVerified) {
                    //             Get.offAll(NameScreen());
                    //           } else {
                    //             String code = "Email is not verified yet";
                    //             var snackbar = SnackBar(content: Text(code));
                    //             // ignore: use_build_context_synchronously
                    //             ScaffoldMessenger.of(context)
                    //                 .showSnackBar(snackbar);
                    //           }
                    //         });
                    //   },
                    // )
                  ]),
            ))),
      ),
    );
  }
}
