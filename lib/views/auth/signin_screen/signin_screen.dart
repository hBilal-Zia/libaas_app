import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/form_validator.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/component/textfield_component.dart';
import 'package:libaas_app/views/auth/reset_screen/reset_screen.dart';
import 'package:libaas_app/views/auth/signin_screen/controller/signin_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController _signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _signInController.signinKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.large,
                      Spaces.large,
                      textGlobalWidget(
                          text: 'Sign in',
                          fontSize: 33.0,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black),
                      Spaces.extrasmall,
                      Row(
                        children: [
                          textGlobalWidget(
                              text: 'New here?   ',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black),
                          GestureDetector(
                            onTap: () {},
                            child: textGlobalWidget(
                                text: 'Sign Up',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                      Spaces.large,
                      Spaces.large,
                      TextFieldComponent(
                        validator: FormValidator.validateEmail,
                        hintText: 'Email',
                        textEditingController:
                            _signInController.emailController,
                      ),
                      Spaces.large,
                      Spaces.smallh,
                      TextFieldComponent(
                        validator: FormValidator.validatePassword,
                        showSuffix: true,
                        hintText: 'Password',
                        textEditingController: _signInController.pwController,
                      ),
                      Spaces.extrasmall,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                textGlobalWidget(
                                    text: 'I agree to the  ',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black),
                                GestureDetector(
                                  onTap: () {},
                                  child: textGlobalWidget(
                                      text: 'terms and Condition',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.black),
                                ),
                              ],
                            ),
                            Transform.scale(
                                scale: 0.9,
                                child: Obx(() {
                                  return Checkbox(
                                      activeColor: Colors.grey.shade800,
                                      checkColor: Colors.white,
                                      value: _signInController.isTick.value,
                                      onChanged: (value) {
                                        _signInController.isTick.value = value!;
                                      });
                                })),
                          ],
                        ),
                      ),
                      Spaces.large,
                      Spaces.large,
                      ButtonComponent(
                        text: 'Sign In',
                        fontSize: 24,
                        onTap: () {
                          if (_signInController.signinKey.currentState!
                              .validate()) {
                            // Validate the form here
                            // Proceed with the sign in process
                          } else if (_signInController.isTick.value == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        'Please tick the terms and condition')));
                          }
                        },
                      ),
                      Spaces.mid,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textGlobalWidget(
                              text: 'Forgot password?   ',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black),
                          GestureDetector(
                            onTap: () {
                              Get.to(ResetScreen());
                            },
                            child: textGlobalWidget(
                                text: 'Reset it',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                    ]),
              ),
            ))),
      ),
    );
  }
}
