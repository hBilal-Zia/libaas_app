import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/app_color.dart';
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
                isShowDone: true,
                btnTxt: 'Show All',
                onClick: () {
                  _closetController.isSelectedItem.value = '';
                  _closetController.getClothesStream();
                },
              ),
            )),
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spaces.large,
                    Spaces.large,
                    SizedBox(
                      height: Get.height * 0.13,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _closetController.categoryNames.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                _closetController.isSelectedItem.value =
                                    _closetController.categoryNames[index];
                                debugPrint(
                                    _closetController.categoryNames[index]);
                                debugPrint(
                                    _closetController.isSelectedItem.value);
                              },
                              child: Column(
                                children: [
                                  Obx(
                                    () => CircleAvatar(
                                      radius: 35,
                                      backgroundColor: _closetController
                                                  .isSelectedItem.value ==
                                              _closetController
                                                  .categoryNames[index]
                                          ? Colors.green.shade500
                                          : Colors.white,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            _closetController
                                                .categoryIcons[index]),
                                      ),
                                    ),
                                  ),
                                  Spaces.smallh,
                                  FittedBox(
                                    child: Text(
                                      _closetController.categoryNames[index],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Spaces.smallh,
                    const Divider(
                      color: ColorConstraint.primaryColor,
                    ),
                    Spaces.smallh,
                    Obx(() {
                      return Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _closetController.getClothesStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text('No item found.'));
                            } else {
                              final List<DocumentSnapshot> dataDocs =
                                  snapshot.data!.docs;
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: dataDocs.length,
                                itemBuilder: (context, index) {
                                  final Map<String, dynamic> item =
                                      dataDocs[index].data()
                                          as Map<String, dynamic>;
                                  debugPrint(item.toString());
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
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
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
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
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.network(
                                                    item['image'],
                                                    fit: BoxFit.contain,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child; // Image is loaded, so show it
                                                      } else {
                                                        return CircularProgressIndicator(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 54, 156, 98),
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: Get.height,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10,
                                                                  right: 10),
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'clothes')
                                                                        .doc(dataDocs[index]
                                                                            .id)
                                                                        .delete();
                                                                    String
                                                                        code =
                                                                        "Item deleted from your closet successfully!!";
                                                                    var snackbar =
                                                                        SnackBar(
                                                                      content: Text(
                                                                          code),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                    );
                                                                    // ignore: use_build_context_synchronously
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            snackbar);
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .delete)),
                                                        )),
                                                    Spaces.mid,
                                                    Center(
                                                      child: textGlobalWidget(
                                                          text:
                                                              '${item['style']} ${item['category']}',
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          textColor:
                                                              Colors.black),
                                                    ),
                                                  ],
                                                ),
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
                      );
                    }),
                    Spaces.smallh,
                  ]),
            ))),
      ),
    );
  }
}
