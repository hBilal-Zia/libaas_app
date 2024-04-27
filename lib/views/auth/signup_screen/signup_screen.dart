import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/form_validator.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/component/textfield_component.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_screen.dart';
import 'package:libaas_app/views/auth/signup_screen/controller/signup_controller.dart';
import 'package:libaas_app/views/auth/signup_screen/term_condition.dart';
import 'package:libaas_app/views/auth/verify_email/verify_email.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignUpController _signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _signUpController.signupKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.large,
                      textGlobalWidget(
                          text: 'Sign up',
                          fontSize: 33.0,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black),
                      Spaces.extrasmall,
                      Row(
                        children: [
                          textGlobalWidget(
                              text: 'Already?   ',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black),
                          GestureDetector(
                            onTap: () {
                              Get.offAll(SignInScreen());
                            },
                            child: textGlobalWidget(
                                text: 'Login in',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                      Spaces.large,
                      TextFieldComponent(
                        validator: FormValidator.validateName,
                        hintText: 'Full name',
                        textEditingController: _signUpController.nameController,
                      ),
                      Spaces.mid,
                      TextFieldComponent(
                        validator: FormValidator.validateEmail,
                        hintText: 'Email',
                        textEditingController:
                            _signUpController.emailController,
                      ),
                      Spaces.mid,
                      TextFieldComponent(
                        validator: FormValidator.validatePassword,
                        showSuffix: true,
                        hintText: 'Password',
                        textEditingController: _signUpController.pwController,
                      ),
                      Spaces.mid,
                      Container(
                        height: 55,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: const Color(0xffF2F0F0),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Obx(() {
                                return Radio(
                                  value: 'Male', // Specify the type explicitly
                                  activeColor: Colors.blue,
                                  groupValue:
                                      _signUpController.genderSelected.value,
                                  onChanged: (String? value) {
                                    // Specify the type explicitly
                                    _signUpController.genderSelected.value =
                                        value!;
                                  },
                                );
                              }),
                              Text(
                                'Male',
                                style: TextStyle(
                                  color: const Color(0xffAAA3A3),
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spaces.midw,
                              Obx(
                                () {
                                  return Radio(
                                    value:
                                        'Female', // Specify the type explicitly
                                    activeColor: Colors.blue,
                                    groupValue:
                                        _signUpController.genderSelected.value,
                                    onChanged: (String? value) {
                                      // Specify the type explicitly
                                      _signUpController.genderSelected.value =
                                          value!;
                                    },
                                  );
                                },
                              ),
                              Text(
                                'Female',
                                style: TextStyle(
                                  color: const Color(0xffAAA3A3),
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spaces.mid,
                      TextFieldComponent(
                        calender: true,
                        showPass: false,
                        showSuffix: true,
                        readOnly: true,
                        calenderClick: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          _signUpController.dayController.text =
                              '${pickedDate!.year}-${pickedDate.month}-${pickedDate.day}';
                          debugPrint(_signUpController.dayController.text);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Select the date';
                          }
                          return null;
                        },
                        hintText: 'Date of birth',
                        textEditingController: _signUpController.dayController,
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
                                  onTap: () {
                                    Get.to(const TermConditionScreen());
                                  },
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
                                      value: _signUpController.isTick.value,
                                      onChanged: (value) {
                                        _signUpController.isTick.value = value!;
                                      });
                                })),
                          ],
                        ),
                      ),
                      Spaces.large,
                      ButtonComponent(
                        text: 'Sign up',
                        fontSize: 24,
                        onTap: () {
                          if (_signUpController.signupKey.currentState!
                              .validate()) {
                            if (_signUpController.dayController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content:
                                      Text('Please select the date of birth'),
                                ),
                              );
                            } else if (!_signUpController.isTick.value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'Please accept the terms and conditions'),
                                ),
                              );
                            } else {
                              _signUpController.signUpUser(context);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please fill all fields'),
                              ),
                            );
                          }
                        },
                      ),
                      Spaces.large,
                      Spaces.large
                    ]),
              ),
            ))),
      ),
    );
  }
}
