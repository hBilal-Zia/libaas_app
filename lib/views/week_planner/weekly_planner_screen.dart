import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/views/recommended/controller/recommend_outfit_controller.dart';
import 'package:libaas_app/views/week_planner/controller/weekly_planner_controller.dart';

import '../../component/appbar_component.dart';

class WeeklyPlannerScreen extends StatelessWidget {
  WeeklyPlannerScreen({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // _recommendedOutfitController.fetchData();

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10.0),
              child: AppBarComponent(
                title: 'Weekly Planner',

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
                SizedBox(
                  height: Get.height * 0.7,
                  width: Get.width,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('weekplanner')
                          .where('outfitUserId',
                              isEqualTo: _auth.currentUser!.uid)
                          // .where('category',
                          //     isEqualTo:
                          //         _closetController.isSelectedItem.value)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 300),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No item found.'));
                        } else {
                          List<DocumentSnapshot> documents =
                              snapshot.data!.docs;

                          documents.sort((a, b) =>
                              a['timestamp'].compareTo(b['timestamp']));

                          return CarouselSlider.builder(
                            itemCount: documents.length,
                            options: CarouselOptions(
                              autoPlay: false,
                              aspectRatio: 0.1,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                            ),
                            itemBuilder: (context, index, realIdx) {
                              final Map<String, dynamic> item = documents[index]
                                  .data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      textGlobalWidget(
                                          text: item['dateDay'],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                          textColor: Colors.black),
                                      Spaces.smallw,
                                      textGlobalWidget(
                                          text: item['time'],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                          textColor: Colors.black),
                                    ],
                                  ),
                                  textGlobalWidget(
                                      text: item['day'],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      textColor: Colors.black),
                                  Spaces.smallh,
                                  Container(
                                    height: Get.height * 0.45,
                                    width: Get.width * 0.66,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          // Positioned(
                                          //   top: 5,
                                          //   right: 5,
                                          //   child: Column(
                                          //     children: [
                                          //       Container(
                                          //         alignment: Alignment.center,
                                          //         width: 50,
                                          //         height: 50,
                                          //         decoration: BoxDecoration(
                                          //             color: ColorConstraint
                                          //                 .primaryColor,
                                          //             borderRadius:
                                          //                 BorderRadius
                                          //                     .circular(
                                          //                         20.0)),
                                          //         child: Image.asset(
                                          //             'asset/images/icon-AR.png'),
                                          //       ),
                                          //       textGlobalWidget(
                                          //           text: 'Try On',
                                          //           fontSize: 10,
                                          //           fontWeight:
                                          //               FontWeight.w700,
                                          //           textColor: Colors.black),
                                          //     ],
                                          //   ),
                                          // ),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Image.network(
                                                item['bottomWear'],
                                                height: 180,
                                              )),
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              // child: Image.network(
                                              //   item.bottomwearImageUrl,
                                              //   height: 200,
                                              // )
                                              child: Image.network(
                                                item['topWear'],
                                                height: 180,
                                              )),
                                          Positioned(
                                              bottom: 0,
                                              left: 0,
                                              child: Image.network(
                                                item['footWear'],
                                                height: 200,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }),
                ),
              ]),
        )),
      ),
    );
  }
}
