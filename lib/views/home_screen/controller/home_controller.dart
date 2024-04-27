import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:libaas_app/views/home_screen/model/weather_model.dart';

class HomeController extends GetxController {
  bool servicePermission = false;
  late LocationPermission permission;
  Position? currentLocation;
  List<Placemark>? placemarks;
  String? currentAddress;
  double? temp;
  WeatherModel? weatherData;
  bool? isLoaded = false;
  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    isLoaded = true;

    currentLocation = await _getCurrentLocation();
    if (currentLocation != null) {
      getWeather(currentLocation!.latitude, currentLocation!.longitude);
      placemarks = await placemarkFromCoordinates(
          currentLocation!.latitude, currentLocation!.longitude);

      Placemark place1 = placemarks![0];
      Placemark place2 = placemarks![1];
      currentAddress =
          "${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}";
      debugPrint(currentAddress.toString());
      Timer(const Duration(seconds: 3), () {
        isLoaded = false;
        update();
      });
      update();
    }
    update();
  }

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();

    if (!servicePermission) {
      print("Service Disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }

  void getWeather(double lat, double long) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=a9c3535ab03caa2cabe84d2df5134601'));

    if (response.statusCode == 200) {
      log(response.body);

      weatherData = WeatherModel.fromJson(jsonDecode(response.body));
      temp = kelvinToCelsius(weatherData?.main?.temp ?? 0.0);

      update();
      log(response.body);
    } else {
      log(response.statusCode.toString());
    }
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }
}
