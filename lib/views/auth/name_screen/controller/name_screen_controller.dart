import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NameScreenController extends GetxController {
  TextEditingController username = TextEditingController();
  final usernameKey = GlobalKey<FormState>();
}
