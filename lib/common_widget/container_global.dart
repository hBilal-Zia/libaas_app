import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget containerGlobalWidget(Widget child) {
  return Container(
    height: Get.height,
    width: Get.width,
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffacdcbc), Color(0xfff4e8e1)])),
    child: child,
  );
}
