import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItemController extends GetxController {
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController seasonController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  File? image; // Declare as nullable
  final picker = ImagePicker();

  RxBool isEditingStyle = false.obs;
  RxBool isEditingCtgry = false.obs;
  RxBool isEditingColor = false.obs;
  RxBool isEditingSeasn = false.obs;
  RxBool isEditingGndr = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    descController.clear();
    categoryController.clear();
    colorController.clear();
    seasonController.clear();
    genderController.clear();
    image = null;
  }

  void imageUpdate() {
    image = null;
    update();
  }

  RxBool isValue = false.obs;
  RxBool isLoading = false.obs;

  Map<String, dynamic> jsonResponse = {};
  bool isImage = false;

  late Uint8List bytes;
  Future<void> addItemFirebase(Map<String, dynamic> data) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('clothes').doc();
      String clotheId = docRef.id;
      data['clotheId'] = clotheId;
      await docRef.set(data);
    } catch (e) {
      debugPrint("Error adding data to Firestore: $e");
      // Handle error as needed
    }
  }

  Future<String?> uploadImageToStorageAndGetURL(Uint8List imageBytes) async {
    try {
      // Generate a unique file name for the image
      String fileName = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Requires uuid package

      // Create a reference to the location you want to upload to in Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('item/$fileName');

      // Upload the image to Firebase Storage
      TaskSnapshot uploadTask = await storageReference.putData(imageBytes);

      // Get the download URL from the uploaded image
      String downloadURL = await uploadTask.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      debugPrint("Error uploading image to Firebase Storage: $e");
      return null;
    }
  }

  void updateImage() {
    isImage = false;
    update();
  }

  String? downloadURL;
  Future<void> uploadImage(File imageData) async {
    const url = 'https://5a2c-38-10-164-228.ngrok-free.app/classify';

    try {
      // Create a multipart request
      isLoading.value = true;
      debugPrint('isloading on ');
      var request = http.MultipartRequest('GET', Uri.parse(url));

      // Open the image file
      final imageBytes = await imageData.readAsBytes();
      final image = http.MultipartFile.fromBytes('image', imageBytes,
          filename: 'image.jpg');

      // Add the image file to the request
      request.files.add(image);

      // Send the request
      var response = await request.send();

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Read and parse the response
        var resp = await response.stream.bytesToString();

        jsonResponse = json.decode(resp);
        log(jsonResponse.toString());
        // Access the 'background_removed_image' from the parsed JSON
        String base64ImageData = jsonResponse['background_removed_image'];
        bytes = base64.decode(base64ImageData);
        downloadURL = await uploadImageToStorageAndGetURL(bytes);
        debugPrint(downloadURL);
        isLoading.value = false;
        debugPrint('isloading off ');
        isImage = true;
        isValue.value = true;
        update();
      } else {
        // If the request was not successful, log the error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Log any errors that occur during the request
      print('Error uploading image: $e');
    }
  }
  // Future<void> uploadImage(File imageData) async {
  //   const url = 'http://10.0.2.2:5000/predict';

  //   // Open the image file
  //   final imageBytes = imageData.readAsBytesSync();
  //   final image = base64Encode(imageBytes);

  //   // Send a POST request to the Flask API endpoint with the image file
  //   final response = await http.post(
  //     Uri.parse(url),
  //     body: {'image': image},
  //   );

  //   var resp = response.body;

  //   log(resp.toString());
  // }

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      uploadImage(image!);

      update();
    }
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      uploadImage(image!);

      update();
    }
  }

  Future showOptions(BuildContext context) async {
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
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
}
