import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class YourClosetController extends GetxController {
  RxString isSelectedItem = ''.obs;
  List<String> categoryNames = [
    'Topwear',
    'Outerwear',
    'Bottomwear',
    'Footwear',
  ];
  List<String> categoryIcons = [
    'asset/images/top.png',
    'asset/images/outer.png',
    'asset/images/bottom.png',
    'asset/images/foot.png',
  ];

  Stream<QuerySnapshot> getClothesStream() {
    return FirebaseFirestore.instance
        .collection('clothes')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('category',
            isEqualTo:
                isSelectedItem.value.isEmpty ? null : isSelectedItem.value)
        .snapshots();
  }
}
