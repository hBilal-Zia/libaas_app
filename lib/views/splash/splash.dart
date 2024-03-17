import 'package:flutter/material.dart';
import 'package:libaas_app/common_widget/container_global.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: containerGlobalWidget(Center(
        child: Image.asset('asset/images/Logo.png'),
      )),
    );
  }
}
