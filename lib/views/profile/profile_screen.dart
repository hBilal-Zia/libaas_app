import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/component/appbar_component.dart';
import 'package:libaas_app/views/profile/date_bottomsheet.dart';
import 'package:libaas_app/views/profile/gender_bottomsheet.dart';
import 'package:libaas_app/views/profile/name_bottomsheet.dart';
import 'package:libaas_app/views/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController _profileController = Get.put(ProfileController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 25.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            )),
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'asset/images/Logo.png',
                          height: 130.0,
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _firestore
                            .collection('user')
                            .doc(_auth.currentUser!.uid)
                            .snapshots(),
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

                            debugPrint(data.toString());
                            return Stack(
                              children: [
                                CircleAvatar(
                                  radius: 53,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 44,
                                    backgroundImage: NetworkImage(
                                      snapshot.data!['image'],
                                    ),
                                    // child: Image.network(
                                    //   data['image'],
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                ),
                                GetBuilder<ProfileController>(
                                  builder: (controller) {
                                    return Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            _profileController
                                                .showOptions(context);
                                          },
                                          child: const CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.blue,
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      Spaces.smallh,
                      StreamBuilder<DocumentSnapshot>(
                        stream: _firestore
                            .collection('user')
                            .doc(_auth.currentUser!.uid)
                            .snapshots(),
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
                              return Column(
                                children: [
                                  ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    title: Text(
                                      data['name'],
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          showNameUpdateBottomSheet(
                                              context, data['name']);
                                        },
                                        child: const Icon(
                                            Icons.arrow_forward_ios)),
                                  ),
                                  Spaces.extrasmall,
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                  Spaces.extrasmall,
                                  ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    title: Text(
                                      data['email'],
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Spaces.extrasmall,
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                  Spaces.extrasmall,
                                  ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    title: Text(
                                      data['dateofbirth'] == ""
                                          ? 'date of birth'
                                          : data['dateofbirth'],
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          showDateUpdateBottomSheet(
                                            context,
                                            data['dateofbirth'] == ""
                                                ? 'date of birth'
                                                : data['dateofbirth'],
                                          );
                                        },
                                        child: const Icon(
                                            Icons.arrow_forward_ios)),
                                  ),
                                  Spaces.extrasmall,
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                  Spaces.extrasmall,
                                  ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    title: Text(
                                      data['gender'] == ""
                                          ? 'gender'
                                          : data['gender'],
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          showGenderUpdateBottomSheet(
                                              context,
                                              data['gender'] == ""
                                                  ? 'gender'
                                                  : data['gender']);
                                        },
                                        child: const Icon(
                                            Icons.arrow_forward_ios)),
                                  ),
                                  Spaces.extrasmall,
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                  Spaces.extrasmall,
                                ],
                              );
                            } else {
                              // If data is null or empty
                              return const Text('No data available');
                            }
                          }
                        },
                      ),
                    ]),
              ),
            ))),
      ),
    );
  }
}
