import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/text_global.dart';

class AppBarComponent extends StatelessWidget {
  final String? title;
  final bool? isBack;
  final bool? isShowUser;
  const AppBarComponent(
      {super.key, this.title, this.isBack = true, this.isShowUser = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, right: 10.0),
      child: AppBar(
        actions: [
          isShowUser == true
              ? CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 24,
                    child: Image.asset('asset/images/user.png'),
                  ),
                )
              : Container(),
        ],
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0.0,
        title: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: 60,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0))),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 30.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isBack == true
                    ? GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        ))
                    : Container(
                        width: 30.0,
                      ), // Leading icon
                const SizedBox(
                    width: 10.0), // Adjust the spacing between icon and title
                textGlobalWidget(
                    text: title ?? 'Term and Condition',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
