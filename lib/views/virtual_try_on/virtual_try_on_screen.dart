import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/views/recommended/controller/recommend_outfit_controller.dart';

import '../../component/appbar_component.dart';

class TryOnScreen extends StatelessWidget {
  String footId;
  String bottomId;
  String topId;
  TryOnScreen({
    super.key,
    required this.footId,
    required this.bottomId,
    required this.topId,
  });

  final RecommendedOutfitController _recommendedOutfitController =
      Get.put(RecommendedOutfitController());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10.0),
              child: AppBarComponent(
                title: 'Virtual Try On',

                // 'Weekly Planner',
                isBack: true,
                isShowUser: false,
                isShowDone: false,
              ),
            )),
        body: containerGlobalWidget(Padding(
          padding: const EdgeInsets.only(top: 90.0, left: 25.0, right: 25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spaces.large,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: ColorConstraint.primaryColor,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: const Icon(
                        Icons.download,
                        color: Colors.white,
                      )),
                ),
                Spaces.large,
                Container(
                  height: Get.height * 0.6,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ),
              ]),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          height: Get.height * 0.12,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: ColorConstraint.primaryColor,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    )),
              ),
              textGlobalWidget(
                  text: 'Generated',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
