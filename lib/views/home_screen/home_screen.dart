import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/appbar_component.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/views/home_screen/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<String> imgList = [
    'asset/images/slider1.png',
    'asset/images/slider2.png',
    'asset/images/slider3.png'
  ];
  // final HomeController _controller = Get.put(HomeController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // Get today's date
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
                title: 'Home',
                isBack: false,
                isShowUser: true,
              ),
            )),
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<DocumentSnapshot>(
                        future: _firestore
                            .collection('user')
                            .doc(_auth.currentUser!.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While data is loading
                            return const CircularProgressIndicator(
                              color: Colors.grey,
                            ); // or any other loading indicator
                          } else if (snapshot.hasError) {
                            // If there's an error
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // When data is successfully loaded
                            Map<String, dynamic>? data =
                                snapshot.data?.data() as Map<String, dynamic>?;

                            if (data != null) {
                              debugPrint(data.toString());
                              return FittedBox(
                                child: textGlobalWidget(
                                    text: 'Hello, ${data['name']}!',
                                    fontSize: 33.0,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black),
                              );
                            } else {
                              // If data is null or empty
                              return const Text('No data available');
                            }
                          }
                        },
                      ),
                      Spaces.smallh,
                      Center(
                        child: textGlobalWidget(
                            text: 'What are you wearing today?',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black),
                      ),
                      Spaces.mid,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            : controller.weatherData
                                                        ?.weather?[0].main ==
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
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
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
                                                      BorderRadius.circular(
                                                          20.0)),
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
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        height: Get.height,
                                        width: Get.width * 0.38,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
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
                                                        BorderRadius.circular(
                                                            6.0)),
                                                child: Image.network(
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
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        textColor:
                                                            Colors.black),
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
                      Spaces.mid,
                      SizedBox(
                          child: CarouselSlider.builder(
                        itemCount: imgList.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 0.9,
                          enlargeCenterPage: true,
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return GestureDetector(
                            onTap: () {
                              debugPrint(index.toString());
                            },
                            child: Center(
                                child: Image.asset(imgList[index],
                                    fit: BoxFit.fitHeight, width: 1000)),
                          );
                        },
                      )),
                      Spaces.mid,
                    ]),
              ),
            ))),
      ),
    );
  }
}
