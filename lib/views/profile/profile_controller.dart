import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController username = TextEditingController();
  final usernameKey = GlobalKey<FormState>();

  File? image; // Declare as nullable
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      log(fileName.toString());
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');

      log(storageReference.toString());
      UploadTask uploadTask = storageReference.putFile(image!);
      log(uploadTask.toString());

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      debugPrint('dsds');
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      debugPrint(imageUrl);

      // Update Firestore document with username and image URL
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'image': imageUrl,
      });
    }
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      log(fileName.toString());
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');

      log(storageReference.toString());
      UploadTask uploadTask = storageReference.putFile(image!);
      log(uploadTask.toString());

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      debugPrint('dsds');
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      debugPrint(imageUrl);

      // Update Firestore document with username and image URL
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'image': imageUrl,
      });
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
