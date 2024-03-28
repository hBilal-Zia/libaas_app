import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/views/auth/name_screen/name_screen.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F0F0),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: textGlobalWidget(
                            text: 'Resend email',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black),
                      ),
                    ),
                    Spaces.large,
                    Spaces.large,
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F0F0),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: textGlobalWidget(
                            text: 'I already confirmed my email',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black),
                      ),
                    ),
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    Spaces.large,
                    ButtonComponent(
                        text: 'Next',
                        fontSize: 24,
                        onTap: () {
                          Get.offAll(NameScreen());
                        }),
                  ]),
            ))),
      ),
    );
  }
}
