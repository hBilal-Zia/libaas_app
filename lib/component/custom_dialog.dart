import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_screen.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Account'),
      content: const Text('Are you sure you want to delete your account?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('user')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .delete();
            User user = FirebaseAuth.instance.currentUser!;
            await user.delete();
            Get.offAll(SignInScreen());
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
