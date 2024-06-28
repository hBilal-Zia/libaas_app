import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:libaas_app/model/recommended_model.dart';

class RecommendedOutfitController extends GetxController {
  bool isLoading = false;

  List<Recommendation> recommendedData = [];

  List<Recommendation> parseRecommendations(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Recommendation>((json) => Recommendation.fromJson(json))
        .toList();
  }

  Future<void> recommendationData(
      String userId, String temp, String eventVal, String venueVal) async {
    const url = 'https://8cb4-38-10-174-236.ngrok-free.app/recommendation';
    Map<String, String> params = {
      'user_id': userId,
      'temperature': temp,
      'event': eventVal,
      'venue': venueVal,
    };
    try {
      isLoading = true;
      var response =
          await http.get(Uri.parse(url).replace(queryParameters: params));
      if (response.statusCode == 200) {
        debugPrint(response.statusCode.toString());
        recommendedData = parseRecommendations(response.body);
        log(recommendedData.length.toString());
        isLoading = false;
        update();
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
