import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/appbar_component.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/component/dropdown_widget.dart';
import 'package:libaas_app/views/create_outfit/controller/create_outfit_controller.dart';
import 'package:libaas_app/views/home_screen/controller/home_controller.dart';
import 'package:libaas_app/views/week_planner/week_planner_screen.dart';

import '../../common_widget/app_color.dart';

class CreateOutfitScreen extends StatefulWidget {
  const CreateOutfitScreen({super.key});

  @override
  State<CreateOutfitScreen> createState() => _CreateOutfitScreenState();
}

class _CreateOutfitScreenState extends State<CreateOutfitScreen> {
  final CreateOutfitController _createOutfitController =
      Get.put(CreateOutfitController());
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Format the date
    String formattedDate = DateFormat('E MMM y').format(now);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10.0),
              child: AppBarComponent(
                title: 'Create Outfit',
                isBack: false,
                isShowUser: false,
                isShowDone: false,
              ),
            )),
        body: containerGlobalWidget(Padding(
          padding: const EdgeInsets.only(top: 90.0, left: 25.0, right: 25.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spaces.large,
                  GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (controller) {
                      return controller.isLoaded == true
                          ? Container(
                              alignment: Alignment.center,
                              height: Get.width * 0.3,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        spreadRadius: 3,
                                        blurRadius: 4)
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    color: ColorConstraint.primaryColor,
                                  ),
                                  Spaces.midw,
                                  textGlobalWidget(
                                      text: 'Finding your location...',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.black),
                                ],
                              ),
                            )
                          : Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: Get.width * 0.3,
                              width: Get.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(controller.weatherData
                                                ?.weather?[0].main ==
                                            'Rain'
                                        ? 'asset/images/rain.PNG'
                                        : controller.weatherData?.weather?[0]
                                                    .main ==
                                                'Clear'
                                            ? 'asset/images/sunny.PNG'
                                            : 'asset/images/cloud.PNG'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 31,
                                            width: 130,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: textGlobalWidget(
                                                text: formattedDate,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                                textColor: Colors.black),
                                          ),
                                        ),
                                        Spaces.mid,
                                        Container(
                                          alignment: Alignment.center,
                                          height: 31,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: textGlobalWidget(
                                              text:
                                                  '${controller.temp?.toInt()} \u2103',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              textColor: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    height: Get.height,
                                    width: Get.width * 0.38,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: ColorConstraint
                                                    .primaryColor
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(6.0)),
                                            child: controller.weatherData
                                                        ?.weather?[0].icon ==
                                                    null
                                                ? const CircularProgressIndicator(
                                                    value: 10,
                                                    strokeWidth: 0.7,
                                                    color: Colors.white,
                                                  )
                                                : Image.network(
                                                    'https://openweathermap.org/img/wn/${controller.weatherData?.weather?[0].icon}@2x.png',
                                                    height: 40,
                                                  ),
                                          ),
                                          textGlobalWidget(
                                              text:
                                                  '${controller.weatherData?.weather?[0].main}',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              textColor: Colors.black),
                                          Spaces.smallh,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.28,
                                                height: 36,
                                                child: textGlobalWidget(
                                                    text:
                                                        '${controller.currentAddress}',
                                                    fontSize: 10.0,
                                                    textAlign: TextAlign.start,
                                                    fontWeight: FontWeight.w600,
                                                    textColor: Colors.black),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                  Spaces.large,
                  Container(
                    alignment: Alignment.center,
                    height: Get.width * 0.25,
                    width: Get.width,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('asset/images/event_image.png')),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 3,
                              blurRadius: 4)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: CustDropDown(
                        items: const [
                          CustDropdownMenuItem(
                            value: 'Sports',
                            child: Text("Sports"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Picnic',
                            child: Text("Picnic"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Concert',
                            child: Text("Concert"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Parties',
                            child: Text("Parties"),
                          )
                        ],
                        hintText: "Event",
                        borderRadius: 5,
                        onChanged: (val) {
                          _createOutfitController.eventValue = val;
                          log(_createOutfitController.eventValue);
                        },
                      ),
                    ),
                  ),
                  Spaces.large,
                  Container(
                    alignment: Alignment.center,
                    height: Get.width * 0.25,
                    width: Get.width,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('asset/images/venue_image.png')),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 3,
                              blurRadius: 4)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: CustDropDown(
                        items: const [
                          CustDropdownMenuItem(
                            value: 'Holidays',
                            child: Text("Holidays"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Traditional days',
                            child: Text("Traditional days"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Wedding',
                            child: Text("Wedding"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Conferences',
                            child: Text("Conferences"),
                          )
                        ],
                        hintText: "Venue",
                        borderRadius: 5,
                        onChanged: (val) {
                          _createOutfitController.venueValue = val;
                          log(_createOutfitController.venueValue);
                        },
                      ),
                    ),
                  ),
                  Spaces.large,
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(WeekPlannerScreen());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: Get.width * 0.35,
                          height: 40,
                          decoration: BoxDecoration(
                              color: ColorConstraint.primaryColor,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: textGlobalWidget(
                              text: 'Weekly Planner',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              textColor: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        )),
      ),
    );
  }
}
