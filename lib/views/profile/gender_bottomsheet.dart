import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GenderBottomSheet extends StatefulWidget {
  final String currentGender;
  final void Function(String newGender) onUpdate;

  const GenderBottomSheet({
    super.key,
    required this.currentGender,
    required this.onUpdate,
  });

  @override
  State<GenderBottomSheet> createState() => _GenderBottomSheetState();
}

class _GenderBottomSheetState extends State<GenderBottomSheet> {
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.currentGender;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select Gender:'),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Radio(
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value.toString();
                  });
                },
              ),
              const Text('Male'),
              const SizedBox(width: 20.0),
              Radio(
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value.toString();
                  });
                },
              ),
              const Text('Female'),
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              widget.onUpdate(_selectedGender);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}

void showGenderUpdateBottomSheet(BuildContext context, String oldGender) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: GenderBottomSheet(
            currentGender: oldGender != 'Male' || oldGender != 'Female'
                ? 'Male'
                : oldGender, // Pass your current gender here
            onUpdate: (String newGender) {
              FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'gender': newGender});
            },
          )));
}
