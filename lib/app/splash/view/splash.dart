import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/utils/images.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Get.find<SplashController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image.asset(Images.login, fit: BoxFit.cover, width: Get.width, height: Get.height));
  }
}
