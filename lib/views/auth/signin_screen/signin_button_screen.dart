import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_screen.dart';
import 'package:libaas_app/views/auth/signup_screen/signup_screen.dart';

class SignInButtonScreen extends StatelessWidget {
  const SignInButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'asset/images/Logo.png',
                height: 150,
              ),
              Spaces.mid,
              LoginButtonComponent(
                onTap: () {
                  Get.to(SignInScreen());
                },
                text: 'Login',
                fontSize: 25,
                backgroundColor: ColorConstraint.primaryColor,
              ),
              Spaces.mid,
              LoginButtonComponent(
                onTap: () {},
                text: 'Sign in with email',
                fontSize: 18,
                textColor: Colors.black,
                backgroundColor: Colors.white,
                isShowIcon: true,
                image: 'asset/images/google_icon.png',
              ),
              Spaces.mid,
              LoginButtonComponent(
                onTap: () {},
                text: 'Continue with facebook',
                fontSize: 16,
                textColor: Colors.white,
                backgroundColor: const Color(0xff2451EE),
                isShowIcon: true,
                image: 'asset/images/facebook_icon.png',
              ),
              Spaces.mid,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textGlobalWidget(
                      text: 'New here?   ',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: textGlobalWidget(
                        text: 'Sign Up',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginButtonComponent extends StatelessWidget {
  String text;
  VoidCallback? onTap;
  Color? backgroundColor;
  Color? textColor;
  double? fontSize;
  bool? isShowIcon;
  String? image;
  LoginButtonComponent(
      {super.key,
      required this.text,
      this.onTap,
      this.backgroundColor,
      this.textColor,
      this.fontSize,
      this.isShowIcon = false,
      this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: Get.width,
        height: 65,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3))
            ],
            color: backgroundColor ?? ColorConstraint.primaryColor,
            borderRadius: BorderRadius.circular(50.0)),
        child: isShowIcon == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    image!,
                    height: 25,
                    fit: BoxFit.fitHeight,
                  ),
                  Spaces.midw,
                  textGlobalWidget(
                      text: text,
                      fontSize: fontSize ?? 28.0,
                      fontWeight: FontWeight.w600,
                      textColor: textColor ?? Colors.white),
                ],
              )
            : textGlobalWidget(
                text: text,
                fontSize: fontSize ?? 28.0,
                fontWeight: FontWeight.w600,
                textColor: textColor ?? Colors.white),
      ),
    );
  }
}
