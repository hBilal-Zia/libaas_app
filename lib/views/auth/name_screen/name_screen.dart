import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/form_validator.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/component/textfield_component.dart';
import 'package:libaas_app/views/auth/name_screen/controller/name_screen_controller.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_screen.dart';
import 'package:libaas_app/views/auth/signup_screen/controller/signup_controller.dart';
import 'package:libaas_app/views/auth/verify_email/verify_email.dart';
import 'package:libaas_app/views/home_screen/controller/home_controller.dart';
import 'package:libaas_app/views/home_screen/nav_bar.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});
  final NameScreenController _nameScreenController =
      Get.put(NameScreenController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _nameScreenController.usernameKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spaces.large,
                      Spaces.large,
                      FutureBuilder<DocumentSnapshot>(
                        future: _firestore
                            .collection('user')
                            .doc(_auth.currentUser!.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While data is loading
                            return const CircularProgressIndicator(); // or any other loading indicator
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
                                    text: 'Hey, ${data['name']}!',
                                    fontSize: 33.0,
                                    fontWeight: FontWeight.w600,
                                    textColor: Colors.black),
                              );
                            } else {
                              // If data is null or empty
                              return const Text('No data available');
                            }
                          }
                        },
                      ),
                      Spaces.extrasmall,
                      SizedBox(
                        width: Get.width,
                        child: textGlobalWidget(
                            text:
                                'Make your digital wardrobe even more personalised by choosing an username & uploading a profile pic and background.',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                            textColor: Colors.black),
                      ),
                      Spaces.large,
                      Spaces.large,
                      SizedBox(
                        height: Get.height * 0.27,
                        child: Stack(
                          children: [
                            Container(
                              height: Get.height * 0.20,
                              decoration: const BoxDecoration(
                                  color: Color(0xffF2F0F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextFormField(
                                  controller: _nameScreenController.username,
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'enter username here..'),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GetBuilder<NameScreenController>(
                                init: NameScreenController(),
                                builder: (controller) {
                                  return controller.image != null
                                      ? CircleAvatar(
                                          radius: 40,
                                          backgroundImage: FileImage(
                                            controller.image!,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _nameScreenController
                                                .showOptions(context);
                                          },
                                          child: Image.asset(
                                              'asset/images/Group 1.png'));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spaces.large,
                      Spaces.large,
                      Spaces.large,
                      ButtonComponent(
                          text: 'Completed',
                          fontSize: 24,
                          onTap: () async {
                            if (_nameScreenController
                                .username.text.isNotEmpty) {
                              try {
                                if (_nameScreenController.image == null) {
                                  // Update Firestore document with username and image URL
                                  await _firestore
                                      .collection('user')
                                      .doc(_auth.currentUser!.uid)
                                      .update({
                                    'userName':
                                        _nameScreenController.username.text,
                                    'image':
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCxqlSNYUW9cmBUymWOYLEvZPQzOVNwBHL6dadFN4y1VR3n7yKBOUrXGWoCo-kC0IWuwY&usqp=CAU',
                                  });
                                } else {
                                  String fileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  debugPrint(fileName.toString());
                                  Reference storageReference = FirebaseStorage
                                      .instance
                                      .ref()
                                      .child('images/$fileName');

                                  debugPrint(storageReference.toString());
                                  UploadTask uploadTask = storageReference
                                      .putFile(_nameScreenController.image!);
                                  debugPrint(uploadTask.toString());

                                  TaskSnapshot taskSnapshot =
                                      await uploadTask.whenComplete(() {});
                                  debugPrint('dsds');
                                  String imageUrl =
                                      await taskSnapshot.ref.getDownloadURL();
                                  debugPrint('dd');

                                  // Update Firestore document with username and image URL
                                  await _firestore
                                      .collection('user')
                                      .doc(_auth.currentUser!.uid)
                                      .update({
                                    'userName':
                                        _nameScreenController.username.text,
                                    'image': imageUrl,
                                  });
                                }

                                // Navigate to NavBar after successful update
                                Get.offAll(const NavBar());
                              } catch (e) {
                                print('Error uploading image: $e');
                                String errorMessage =
                                    "An error occurred while uploading the image.";
                                var snackbar = SnackBar(
                                  content: Text(errorMessage),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackbar,
                                );
                              }
                            } else {
                              String errorMessage =
                                  "Please fill in both username and select an image.";
                              var snackbar = SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackbar,
                              );
                            }
                          }),
                    ]),
              ),
            ))),
      ),
    );
  }
}
