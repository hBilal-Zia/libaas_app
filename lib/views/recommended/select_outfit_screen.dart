import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/notification_service.dart';
import 'package:libaas_app/common_widget/schedule.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/views/recommended/controller/recommend_outfit_controller.dart';
import 'package:libaas_app/views/virtual_try_on/virtual_try_on_screen.dart';

import '../../component/appbar_component.dart';

class SelectOutFitScreen extends StatelessWidget {
  String footWear;
  String topWear;
  String bottomWear;
  String footId;
  String bottomId;
  String topId;
  SelectOutFitScreen({
    super.key,
    required this.footWear,
    required this.topWear,
    required this.bottomWear,
    required this.footId,
    required this.bottomId,
    required this.topId,
  });

  // Map<String, dynamic> data = {
  //   'shirt': 'asset/images/week_image2.png',
  //   'pant': 'asset/images/week_image3.png'
  // };
  final RecommendedOutfitController _recommendedOutfitController =
      Get.put(RecommendedOutfitController());
  DateTime? selectedDateTime;
  String getDayOfWeek(DateTime dateTime) {
    return DateFormat.EEEE()
        .format(dateTime); // Returns day of the week (e.g., "Monday")
  }

  String getFormattedDate(DateTime dateTime) {
    return DateFormat('dd MMM')
        .format(dateTime); // Returns formatted date (e.g., "26 Oct")
  }

  String getFormattedDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm a').format(
        dateTime); // Returns formatted date and time (e.g., "12/12/2024 3:40 PM")
  }

  String getFormattedTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(
        dateTime); // Returns formatted date and time (e.g., "12/12/2024 3:40 PM")
  }

  String updateDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss a');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future<void> selectDateTime(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    log(topId);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10.0),
              child: AppBarComponent(
                  title: 'Select Outfit',

                  // 'Weekly Planner',
                  isBack: true,
                  isShowUser: false,
                  isShowDone: true,
                  onClick: () async {
                    await selectDateTime(context);
                    String day = getDayOfWeek(selectedDateTime!);
                    String dateDay = getFormattedDate(selectedDateTime!);
                    String date = getFormattedDateTime(selectedDateTime!);
                    String time = getFormattedTime(selectedDateTime!);
                    if (selectedDateTime != null) {
                      // Save to Firestore
                      FirebaseFirestore.instance.collection('weekplanner').add({
                        'outfitUserId': _auth.currentUser!.uid,
                        'day': day,
                        'dateDay': dateDay,
                        'date': date,
                        'time': time,
                        'timestamp':
                            Timestamp.now(), // Store timestamp for sorting
                        'topWear': topWear, // Replace with your variables
                        'bottomWear': bottomWear,
                        'footWear': footWear,
                      }).then((_) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Outfit saved successfully'),
                        ));
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Failed to save outfit: $error'),
                        ));
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please select date and time first'),
                      ));
                    }
                    CollectionReference clothes =
                        FirebaseFirestore.instance.collection('clothes');
                    QuerySnapshot topSnapshot =
                        await clothes.where('clotheId', isEqualTo: topId).get();
                    QuerySnapshot footSnapshot = await clothes
                        .where('clotheId', isEqualTo: footId)
                        .get();
                    QuerySnapshot btmSnapshot = await clothes
                        .where('clotheId', isEqualTo: bottomId)
                        .get();
                    if (topSnapshot.docs.isNotEmpty &&
                        footSnapshot.docs.isNotEmpty &&
                        btmSnapshot.docs.isNotEmpty) {
                      DocumentSnapshot topDocument = topSnapshot.docs.first;
                      DocumentSnapshot footDocument = footSnapshot.docs.first;
                      DocumentSnapshot btmDocument = btmSnapshot.docs.first;

                      await topDocument.reference.update({
                        'lastUsed': updateDate(),
                      });

                      await btmDocument.reference.update({
                        'lastUsed': updateDate(),
                      });

                      await footDocument.reference.update({
                        'lastUsed': updateDate(),
                      });
                    }
                    DateTime selectedTime =
                        selectedDateTime!.subtract(const Duration(hours: 2));
                    // log("${selectedTime}SSSS SLECTEDD");

                    NotificationService.scheduleNotification(
                        schedule: Schedule(
                            details: 'You have a cloth to wear at $time',
                            time: selectedTime));
                  }),
            )),
        body: containerGlobalWidget(Padding(
          padding: const EdgeInsets.only(top: 90.0, left: 25.0, right: 25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spaces.large,
                Container(
                  height: Get.height * 0.6,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.network(
                              bottomWear,
                              height: 250,
                            )),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Image.network(
                              topWear,
                              height: 250,
                            )),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Image.network(
                              footWear,
                              height: 250,
                            ))
                      ],
                    ),
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
                onTap: () async {
                  await _recommendedOutfitController.showOptions(
                      context, topId, bottomId, footId);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: ColorConstraint.primaryColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Image.asset('asset/images/icon-AR.png'),
                ),
              ),
              textGlobalWidget(
                  text: 'Try On',
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
