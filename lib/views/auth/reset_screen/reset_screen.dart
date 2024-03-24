import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/form_validator.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/appbar_component.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/component/textfield_component.dart';
import 'package:libaas_app/views/auth/reset_screen/controller/reset_controller.dart';

class ResetScreen extends StatelessWidget {
  ResetScreen({super.key});

  final ResetController _resetController = Get.put(ResetController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(55), child: AppBarComponent()),
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _resetController.resetKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.large,
                      Spaces.large,
                      Spaces.large,
                      textGlobalWidget(
                          text: 'Forgot Password',
                          fontSize: 33.0,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black),
                      Spaces.large,
                      Spaces.large,
                      Spaces.large,
                      TextFieldComponent(
                        validator: FormValidator.validateEmail,
                        hintText: 'hamza@gmail.com',
                        textEditingController: _resetController.emailController,
                      ),
                      Spaces.large,
                      Spaces.large,
                      Spaces.large,
                      ButtonComponent(
                        text: 'Reset Password',
                        fontSize: 24,
                        onTap: () {
                          if (_resetController.resetKey.currentState!
                              .validate()) {
                            // Validate the form here
                            // Proceed with the sign in process
                          }
                        },
                      ),
                    ]),
              ),
            ))),
      ),
    );
  }
}
