import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/form_validator.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/component/textfield_component.dart';
import 'package:libaas_app/views/auth/name_screen/controller/name_screen_controller.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_screen.dart';
import 'package:libaas_app/views/auth/signup_screen/controller/signup_controller.dart';
import 'package:libaas_app/views/auth/verify_email/verify_email.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});
  final NameScreenController _nameScreenController =
      Get.put(NameScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _nameScreenController.usernameKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.large,
                      Spaces.large,
                      textGlobalWidget(
                          text: 'Hey, Hamza!',
                          fontSize: 33.0,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black),
                      Spaces.extrasmall,
                      SizedBox(
                        width: Get.width,
                        child: textGlobalWidget(
                            text:
                                'Make your digital wardrobe even more personalised by choosing an username & uploading a profile pic and background.',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                            textColor: Colors.black),
                      ),
                      Spaces.large,
                      Spaces.large,
                      SizedBox(
                        height: Get.height * 0.27,
                        child: Stack(
                          children: [
                            Container(
                              height: Get.height * 0.20,
                              decoration: const BoxDecoration(
                                  color: Color(0xffF2F0F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'enter username here..'),
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset('asset/images/Group 1.png')),
                          ],
                        ),
                      ),
                      Spaces.large,
                      Spaces.large,
                      Spaces.large,
                      ButtonComponent(
                          text: 'Completed',
                          fontSize: 24,
                          onTap: () {
                            // Get.offAll(const HomeScreen());
                          }),
                    ]),
              ),
            ))),
      ),
    );
  }
}
