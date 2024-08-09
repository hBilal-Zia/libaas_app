import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/appbar_component.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  Stream<QuerySnapshot> _getScheduleStream() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String? userId = auth.currentUser?.uid;

    if (userId == null) {
      return const Stream
          .empty(); // Return an empty stream if no user is authenticated
    }

    // Get current time
    DateTime now = DateTime.now();

    // Calculate start and end of today based on current time
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    // Convert to Firestore Timestamp
    Timestamp startTimestamp = Timestamp.fromDate(startOfDay);
    Timestamp endTimestamp = Timestamp.fromDate(endOfDay);

    // Query Firestore
    return firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        // .where('scheduleTime', isGreaterThanOrEqualTo: startTimestamp)
        // .where('scheduleTime', isLessThanOrEqualTo: endTimestamp)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 10.0),
            child: AppBarComponent(
              title: 'Notification',
              isBack: false,
              isShowUser: false,
              isShowDone: false,
            ),
          ),
        ),
        body: containerGlobalWidget(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(
                    height: 90.0), // Added SizedBox instead of Padding
                Center(
                  child: textGlobalWidget(
                    text: 'Activity',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _getScheduleStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text('No Notification found.'));
                      } else {
                        final List<DocumentSnapshot> dataDocs =
                            snapshot.data!.docs;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: dataDocs.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> item =
                                dataDocs[index].data() as Map<String, dynamic>;
                            debugPrint(item.toString());
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: ListTile(
                                    title: Text(
                                      item['title'],
                                    ),
                                    subtitle: Text(
                                      item['details'],
                                    )) // Displaying the item as a placeholder
                                );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String fixTimestampFormat(String timestamp) {
    final RegExp regex =
        RegExp(r'(\d{4}-\d{2}-\d{2}T)(\d{1,2}):(\d{2}):(\d{2})\.\d+');
    return timestamp.replaceAllMapped(regex, (match) {
      final hour = match.group(2)?.padLeft(2, '0') ?? '00';
      return '${match.group(1)}$hour:${match.group(3)}:${match.group(4)}.000';
    });
  }
}
