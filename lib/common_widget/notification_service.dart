import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libaas_app/common_widget/schedule.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
          defaultColor: Colors.transparent,
          locked: true,
          enableVibration: true,
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          playSound: true,
          channelKey: 'flutter_schedule_app_channel',
          channelName: 'Flutter Schedule App Channel',
          channelDescription:
              'This channel is responsible for schedule app notification')
    ]);
  }

  static Future<void> scheduleNotification({required Schedule schedule}) async {
    Random random = Random();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: random.nextInt(1000000) + 1,
            channelKey: 'flutter_schedule_app_channel',
            title: 'Cloth Reminder',
            body: schedule.details,
            category: NotificationCategory.Reminder,
            notificationLayout: NotificationLayout.BigText,
            locked: true,
            wakeUpScreen: true,
            autoDismissible: false,
            fullScreenIntent: true,
            backgroundColor: Colors.transparent),
        schedule: NotificationCalendar(
          minute: schedule.time.minute,
          hour: schedule.time.hour,
          day: schedule.time.day,
          weekday: schedule.time.weekday,
          month: schedule.time.month,
          year: schedule.time.year,
          preciseAlarm: true,
          allowWhileIdle: true,
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        ),
        actionButtons: [
          NotificationActionButton(
              key: "Close", label: "Close Reminder", autoDismissible: true),
        ]);
    await FirebaseFirestore.instance.collection('notifications').add({
      'notificationId': random.nextInt(1000000) + 1,
      'title': 'Cloth Reminder',
      'details': schedule.details,
      'scheduledTime': schedule.time.toIso8601String(),
      'createdAt': FieldValue.serverTimestamp(),
      'userId': FirebaseAuth.instance.currentUser!.uid
    }).catchError((error) {
      print("Failed to add notification: $error");
    });
  }
}
