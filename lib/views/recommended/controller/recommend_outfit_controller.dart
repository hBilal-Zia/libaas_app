import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:libaas_app/model/recommended_model.dart';
import 'package:libaas_app/views/virtual_try_on/virtual_try_on_screen.dart';

class RecommendedOutfitController extends GetxController {
  bool isLoading = false;
  File? image; // Declare as nullable
  final picker = ImagePicker();
  List<Recommendation> recommendedData = [];

  List<Recommendation> parseRecommendations(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Recommendation>((json) => Recommendation.fromJson(json))
        .toList();
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);

      update();
    }
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      update();
    }
  }

  Future showOptions(BuildContext context, String topId, String bottomId,
      String footId) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
              if (image != null) {
                Get.to(TryOnScreen(
                    footId: footId, bottomId: bottomId, topId: topId));
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
              if (image != null) {
                Get.to(TryOnScreen(
                    footId: footId, bottomId: bottomId, topId: topId));
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> recommendationData(
      String userId, String temp, String eventVal, String venueVal) async {
    const url = 'https://8e88-39-34-147-183.ngrok-free.app/recommendation';
    Map<String, String> params = {
      'user_id': userId,
      'temperature': temp,
      'event': eventVal,
      'venue': venueVal,
    };
    try {
      isLoading = true;
      var response =
          await http.get(Uri.parse(url).replace(queryParameters: params));
      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
        recommendedData = parseRecommendations(response.body);

        log(recommendedData[0].footwearImageUrl.toString());
        log(recommendedData[1].footwearImageUrl.toString());

        isLoading = false;
        update();
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
