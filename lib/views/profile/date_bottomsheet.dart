import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateUpdateBottomSheet extends StatefulWidget {
  final DateTime currentDate;
  final void Function(String newDate) onUpdate;

  const DateUpdateBottomSheet({
    super.key,
    required this.currentDate,
    required this.onUpdate,
  });

  @override
  _DateUpdateBottomSheetState createState() => _DateUpdateBottomSheetState();
}

class _DateUpdateBottomSheetState extends State<DateUpdateBottomSheet> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.currentDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select Date of Birth:'),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            child: Text(
              '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              widget.onUpdate(
                  '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}');
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}

void showDateUpdateBottomSheet(BuildContext context, String oldDate) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: DateUpdateBottomSheet(
            currentDate: DateTime.now(), // Pass your current date here
            onUpdate: (String newDate) {
              FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'dateofbirth': newDate.toString()});
            },
          )));
}
