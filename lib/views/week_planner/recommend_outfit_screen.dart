import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/views/week_planner/controller/recommend_outfit_controller.dart';

import '../../component/appbar_component.dart';

class RecommendedOutFitScreen extends StatelessWidget {
  RecommendedOutFitScreen({super.key});

  List<Map<String, dynamic>> data = [
    {
      'date': 'Oct 23',
      'day': 'Monday',
      'shirt': 'asset/images/week_image1.png',
      'pant': 'asset/images/week_image3.png'
    },
    {
      'date': 'Oct 24',
      'day': 'Tuesday',
      'shirt': 'asset/images/week_image2.png',
      'pant': 'asset/images/week_image3.png'
    },
    {
      'date': 'Oct 25',
      'day': 'Wednesday',
      'shirt': 'asset/images/week_image1.png',
      'pant': 'asset/images/week_image3.png'
    },
    {
      'date': 'Oct 26',
      'day': 'Thursday',
      'shirt': 'asset/images/week_image2.png',
      'pant': 'asset/images/week_image3.png'
    }
  ];
  final RecommendedOutfitController _recommendedOutfitController = Get.find();

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
                title: 'Recommended Outfit',

                // 'Weekly Planner',
                isBack: true,
                isShowUser: false,
                isShowDone: false,
              ),
            )),
        body: containerGlobalWidget(Padding(
          padding: const EdgeInsets.only(top: 90.0, left: 25.0, right: 25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<RecommendedOutfitController>(
                  init: RecommendedOutfitController(),
                  builder: (controller) {
                    return controller.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 54, 156, 98),
                            ),
                          )
                        : SizedBox(
                            height: Get.height * 0.7,
                            width: Get.width,
                            child: controller.recommendedData.isEmpty
                                ? Center(
                                    child: textGlobalWidget(
                                        text: 'No Outfit Recommended',
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        textColor: Colors.black),
                                  )
                                : CarouselSlider.builder(
                                    itemCount:
                                        controller.recommendedData.length,
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      aspectRatio: 0.1,
                                      enableInfiniteScroll: false,
                                      enlargeCenterPage: true,
                                    ),
                                    itemBuilder: (context, index, realIdx) {
                                      final item =
                                          controller.recommendedData[index];
                                      return Column(
                                        children: [
                                          // textGlobalWidget(
                                          //     text: item['date'],
                                          //     fontSize: 20.0,
                                          //     fontWeight: FontWeight.w700,
                                          //     textColor: Colors.black),
                                          // textGlobalWidget(
                                          //     text: item['day'],
                                          //     fontSize: 20.0,
                                          //     fontWeight: FontWeight.w700,
                                          //     textColor: Colors.black),
                                          Spaces.smallh,
                                          Container(
                                            height: Get.height * 0.45,
                                            width: Get.width * 0.66,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Image.network(
                                                        item.bottomwearImageUrl,
                                                        height: 200,
                                                      )),
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Image.network(
                                                        item.topImageUrl,
                                                        height: 200,
                                                      )),
                                                  Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      child: Image.network(
                                                        item.footwearImageUrl,
                                                        height: 200,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ));
                  },
                )
              ]),
        )),
      ),
    );
  }
}
