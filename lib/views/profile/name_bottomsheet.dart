import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/views/profile/profile_screen.dart';

class NameBottomSheet extends StatefulWidget {
  final String currentName;
  final void Function(String newName) onUpdate;

  const NameBottomSheet({
    super.key,
    required this.currentName,
    required this.onUpdate,
  });

  @override
  State<NameBottomSheet> createState() => _NameBottomSheetState();
}

class _NameBottomSheetState extends State<NameBottomSheet> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'New Name'),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              String newName = _nameController.text.trim();
              widget.onUpdate(newName);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

void showNameUpdateBottomSheet(BuildContext context, String oldName) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: NameBottomSheet(
            currentName: oldName, // Pass your current name here
            onUpdate: (String newName) {
              FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'name': newName});
            },
          )));
}
