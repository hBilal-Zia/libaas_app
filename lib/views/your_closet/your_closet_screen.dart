import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/appbar_component.dart';
import 'package:libaas_app/views/add_item/item_detail_screen.dart';
import 'package:libaas_app/views/your_closet/controller/closet_controller.dart';

class YourClosetScreen extends StatelessWidget {
  YourClosetScreen({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final YourClosetController _closetController =
      Get.put(YourClosetController());
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
                title: 'Your Closet',
                isBack: true,
                isShowUser: false,
              ),
            )),
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Spaces.smallh,
                      // SizedBox(
                      //   height: Get.height * 0.2,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: _closetController.categoryNames.length,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(right: 15.0),
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             _closetController.isSelectedItem.value =
                      //                 _closetController.categoryNames[index];
                      //             debugPrint(
                      //                 _closetController.categoryNames[index]);
                      //             debugPrint(
                      //                 _closetController.isSelectedItem.value);
                      //           },
                      //           child: Column(
                      //             children: [
                      //               CircleAvatar(
                      //                 radius: 35,
                      //                 backgroundColor: Colors.white,
                      //                 child: CircleAvatar(
                      //                   radius: 25,
                      //                   backgroundImage: AssetImage(
                      //                       _closetController
                      //                           .categoryIcons[index]),
                      //                 ),
                      //               ),
                      //               Spaces.smallh,
                      //               FittedBox(
                      //                 child: Text(
                      //                   _closetController.categoryNames[index],
                      //                   style: const TextStyle(
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.w800,
                      //                       overflow: TextOverflow.ellipsis,
                      //                       fontSize: 14),
                      //                   textAlign: TextAlign.center,
                      //                   maxLines: 1,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // Spaces.mid,
                      // Obx(() {
                      //   return

                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('clothes')
                            .where('userId', isEqualTo: _auth.currentUser!.uid)
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
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 300),
                              child: Center(child: Text('No item found.')),
                            );
                          } else {
                            final List<DocumentSnapshot> dataDocs =
                                snapshot.data!.docs;

                            return ListView.builder(
                              itemCount: dataDocs.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final Map<String, dynamic> item =
                                    dataDocs[index].data()
                                        as Map<String, dynamic>;
                                debugPrint(item.toString());
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(ItemDetailScreen(
                                          image: item['image'],
                                          style: item['style'],
                                          category: item['category'],
                                          color: item['color'],
                                          season: item['season'],
                                          gender: item['gender']));
                                    },
                                    child: Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      height: Get.height * 0.19,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: index == 0
                                              ? const BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(15.0),
                                                  topRight:
                                                      Radius.circular(15.0))
                                              : BorderRadius.zero),
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: Get.height,
                                            width: Get.width * 0.45,
                                            color: const Color(0xffC4C4C4),
                                            child: Image.network(
                                              item['image'],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: Get.height,
                                              child: textGlobalWidget(
                                                  text:
                                                      '${item['style']} ${item['category']}',
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                  textColor: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      // }),
                      Spaces.smallh,
                    ]),
              ),
            ))),
      ),
    );
  }
}
