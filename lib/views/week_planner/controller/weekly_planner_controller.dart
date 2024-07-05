import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:libaas_app/model/recommended_model.dart';

class WeeklyPlannerController extends GetxController {
  bool isLoading = false;

  List<Recommendation> recommendedData = [];

  List<Recommendation> parseRecommendations(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Recommendation>((json) => Recommendation.fromJson(json))
        .toList();
  }
}
