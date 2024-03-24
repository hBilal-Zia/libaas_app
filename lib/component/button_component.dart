import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/common_widget/text_global.dart';

// ignore: must_be_immutable
class ButtonComponent extends StatelessWidget {
  String text;
  VoidCallback? onTap;
  double? fontSize;
  ButtonComponent(
      {super.key, required this.text, this.onTap, this.fontSize = 28.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: Get.width,
        height: 55,
        decoration: BoxDecoration(
            color: ColorConstraint.primaryColor,
            borderRadius: BorderRadius.circular(20.0)),
        child: textGlobalWidget(
            text: text,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            textColor: Colors.white),
      ),
    );
  }
}
