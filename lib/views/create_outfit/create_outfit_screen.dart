import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:libaas_app/views/recommended/controller/recommend_outfit_controller.dart';
import 'package:libaas_app/views/recommended/recommend_outfit_screen.dart';

import '../../common_widget/app_color.dart';

class CreateOutfitScreen extends StatefulWidget {
  const CreateOutfitScreen({super.key});

  @override
  State<CreateOutfitScreen> createState() => _CreateOutfitScreenState();
}

class _CreateOutfitScreenState extends State<CreateOutfitScreen> {
  final CreateOutfitController _createOutfitController =
      Get.put(CreateOutfitController());
  final HomeController _homeController = Get.find();
  final RecommendedOutfitController _recommendedOutfitController =
      Get.put(RecommendedOutfitController());
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
                        maxListHeight: Get.height * 0.15,
                        items: const [
                          CustDropdownMenuItem(
                            value: 'Wedding',
                            child: Text("Wedding"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Valima',
                            child: Text("Valima"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Business',
                            child: Text("Business"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Presentation',
                            child: Text("Presentation"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Convocation',
                            child: Text("Convocation"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Eid',
                            child: Text("Eid"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Party',
                            child: Text("Party"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Picnic',
                            child: Text("Picnic"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Friends Meetup',
                            child: Text("Friends Meetup"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Shopping',
                            child: Text("Shopping"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Sport',
                            child: Text("Sport"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Family Gathering',
                            child: Text("Family Gathering"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Hiking',
                            child: Text("Hiking"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Concerts',
                            child: Text("Concerts"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Outing',
                            child: Text("Outing"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Mehndi/Mayon',
                            child: Text("Mehndi/Mayon"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Birthday',
                            child: Text("Birthday"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Anniversary',
                            child: Text("Anniversary"),
                          ),
                        ],
                        hintText: "Event",
                        borderRadius: 5,
                        onChanged: (val) {
                          _createOutfitController.eventValue = val;
                          _createOutfitController.update();
                          log(_createOutfitController.eventValue);
                        },
                      ),
                    ),
                  ),
                  Spaces.smallh,
                  Center(
                      child: GetBuilder<CreateOutfitController>(
                    init: CreateOutfitController(),
                    builder: (controller) {
                      return textGlobalWidget(
                          text: controller.eventValue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start,
                          textColor: Colors.black);
                    },
                  )),
                  Spaces.smallh,
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
                        maxListHeight: Get.height * 0.15,
                        items: const [
                          CustDropdownMenuItem(
                            value: 'University',
                            child: Text("University"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Home',
                            child: Text("Home"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Hall/Banquet',
                            child: Text("Hall/Banquet"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Restaurant',
                            child: Text("Restaurant"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Park/Ground',
                            child: Text("Park/Ground"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Beach',
                            child: Text("Beach"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Mall',
                            child: Text("Mall"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Market/Bazar',
                            child: Text("Market/Bazar"),
                          ),
                          CustDropdownMenuItem(
                            value: 'Office',
                            child: Text("Office"),
                          ),
                        ],
                        hintText: "Venue",
                        borderRadius: 5,
                        onChanged: (val) {
                          _createOutfitController.venueValue = val;
                          _createOutfitController.update();
                          log(_createOutfitController.venueValue);
                        },
                      ),
                    ),
                  ),
                  Spaces.smallh,
                  Center(
                      child: GetBuilder<CreateOutfitController>(
                    init: CreateOutfitController(),
                    builder: (controller) {
                      return textGlobalWidget(
                          text: controller.venueValue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start,
                          textColor: Colors.black);
                    },
                  )),
                  Spaces.smallh,
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: GestureDetector(
                        onTap: () {
                          String userId =
                              FirebaseAuth.instance.currentUser!.uid;

                          // Get the selected values
                          String event = _createOutfitController.eventValue;
                          String venue = _createOutfitController.venueValue;

                          // Define valid combinations (you can customize this as per your requirements)
                          Map<String, List<String>> validCombinations = {
                            'Wedding': [
                              "Hall/Banquet",
                              "Restaurant",
                              "Park/Ground",
                              "Home"
                            ],
                            'Valima': ["Hall/Banquet", "Restaurant", "Home"],
                            'Business': ["Office", "Restaurant"],
                            'Presentation': ["University", "Office"],
                            'Convocation': ["University", "Hall/Banquet"],
                            'Eid': ["Home", "Park/Ground", "Restaurant"],
                            'Party': [
                              "Home",
                              "Hall/Banquet",
                              "Restaurant",
                              "Park/Ground",
                              "Beach"
                            ],
                            'Picnic': ["Park/Ground", "Beach"],
                            'Friends Meetup': [
                              "Home",
                              "Restaurant",
                              "Mall",
                              "Park/Ground",
                              "Beach"
                            ],
                            'Shopping': ["Mall", "Market/Bazar"],
                            'Sport': ["Park/Ground", "Beach"],
                            'Family Gathering': [
                              "Home",
                              "Park/Ground",
                              "Restaurant"
                            ],
                            'Hiking': ["Park/Ground"],
                            'Concerts': ["Park/Ground", "Hall/Banquet"],
                            'Outing': [
                              "Park/Ground",
                              "Beach",
                              "Restaurant",
                              "Mall"
                            ],
                            'Mehndi/Mayon': ["Hall/Banquet", "Home"],
                            'Birthday': [
                              "Home",
                              "Restaurant",
                              "Park/Ground",
                              "Hall/Banquet"
                            ],
                            'Anniversary': [
                              "Restaurant",
                              "Home",
                              "Hall/Banquet"
                            ]
                          };

                          // Check if the selected combination is valid
                          if (validCombinations.containsKey(event) &&
                              !validCombinations[event]!.contains(venue)) {
                            // Invalid combination, show a message
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: textGlobalWidget(
                                    text: 'Invalid Selection',
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                    textColor: ColorConstraint.primaryColor),
                                content: textGlobalWidget(
                                    text:
                                        'The selected event and venue do not match. Please select a valid combination.',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstraint.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            // Valid combination, proceed to fetch recommended outfit
                            _recommendedOutfitController.recommendationData(
                                'MQHQ1fm51ZgcbfYIEhaDSidGEKu2',
                                _homeController.temp!.toInt().toString(),
                                event,
                                venue);

                            Get.to(RecommendedOutFitScreen());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          alignment: Alignment.center,
                          width: Get.width * 0.43,
                          decoration: BoxDecoration(
                              color: ColorConstraint.primaryColor,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: textGlobalWidget(
                              text: 'Recommended Outfit',
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
