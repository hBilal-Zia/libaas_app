import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:libaas_app/model/recommended_model.dart';
import 'package:libaas_app/views/virtual_try_on/virtual_try_on_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecommendedOutfitController extends GetxController {
  bool isLoading = false;
  RxBool isLoadingVirtual = false.obs;
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

  Future showOptions(BuildContext context1, String topId, String bottomId,
      String footId) async {
    log(topId);
    log(bottomId);
    showCupertinoModalPopup(
      context: context1,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();

              if (image != null) {
                await _uploadImage(bottomId, topId, image!, context1);
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
              if (image != null) {
                await _uploadImage(bottomId, topId, image!, context1);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> saveImage(Uint8List image) async {
    // Request storage permission
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      // Handle the case when permission is not granted
      Get.snackbar('Permission Denied',
          'Please grant storage permission to save the image.');
      return;
    }

    try {
      // Get the directory to save the file
      final directory = await getExternalStorageDirectory();
      final path = '${directory!.path}/libaasapp';

      // Create the directory if it doesn't exist
      final saveDir = Directory(path);
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      // Generate a random file name
      final randomFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '$path/$randomFileName';

      // Save the file
      final file = File(filePath);
      await file.writeAsBytes(image);

      Get.snackbar('Success', 'Image saved to $filePath');
    } catch (e) {
      print('Error saving image: $e');
      Get.snackbar('Error', 'Failed to save the image.');
    }
  }
  // Future<void> virtualTryOnAPI(
  //     String imagePath, String bottomWearId, String topWearId) async {
  //   String url =
  //       'https://0a1d-35-240-238-179.ngrok-free.app/virtual_try_on'; // Replace with your actual Flask API URL

  //   // Create multipart request
  //   var request = http.MultipartRequest('GET', Uri.parse(url));
  //   request.fields['bottom_wear'] = "5JdgxLTo5ajPFVOwYfHW";
  //   request.fields['top_wear'] = "LaAFHZrOD7EExTKQDSQq";
  //   request.files.add(await http.MultipartFile.fromPath('image', imagePath));

  //   // Send the request and wait for the response
  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     var responseData = await response.stream.bytesToString();
  //     var data = json.decode(responseData);
  //     String tryOnImageBase64 = data['try_on_image'];
  //     print("Received try-on image (base64): $tryOnImageBase64");

  //     // Decode the base64 image and save it as a file
  //     final directory = await getApplicationDocumentsDirectory();
  //     final imagePath = '${directory.path}/try_on_image.png';
  //     File imageFile = File(imagePath);
  //     imageFile.writeAsBytesSync(base64Decode(tryOnImageBase64));
  //     print('Image saved as $imagePath');
  //   } else {
  //     print("Failed to get try-on image. Status code: ${response.statusCode}");
  //   }
  // }

  Future<void> _uploadImage(String bottomwearId, String topwearId,
      File imageData, BuildContext context) async {
    const String apiUrl =
        'https://0297-35-185-186-16.ngrok-free.app/virtual_try_on';
    isLoadingVirtual.value = true;
    log(isLoadingVirtual.value.toString());
    update();
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        var request = http.MultipartRequest('GET', Uri.parse(apiUrl));

        request.fields['bottom_wear'] = bottomwearId;
        request.fields['top_wear'] = topwearId;
        // Open the image file
        final imageBytes = await imageData.readAsBytes();
        final image = http.MultipartFile.fromBytes('image', imageBytes,
            filename: 'image.jpg');

        // Add the image file to the request
        request.files.add(image);

        // Send the request
        var response = await request.send();
        if (response.statusCode == 200) {
// Read the response
          var responseData = await response.stream.bytesToString();
          var decodedData = jsonDecode(responseData);
          String tryOnImageBase64 = decodedData['try_on_image'];

          // Decode Base64 to bytes
          final imageBytes = base64Decode(tryOnImageBase64);

          isLoadingVirtual.value = false;
          update();

          // Navigate to TryOnScreen with the decoded image bytes
          Get.to(() => TryOnScreen(image: imageBytes));
        } else {
          print('Error: ${response.statusCode}');
          const snackBar = SnackBar(
            content: Text('Failed to get a valid response from the API.'),
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          isLoadingVirtual.value = false;
          update();
        }
      },
    );
  }

  Future<void> recommendationData(
      String userId, String temp, String eventVal, String venueVal) async {
    const url = 'https://0297-35-185-186-16.ngrok-free.app/recommendation';
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
      log(response.body.toString());
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
