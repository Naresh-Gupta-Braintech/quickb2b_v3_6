import 'package:flutter/material.dart';
import 'package:quickb2b_v3_6/utils/images.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [Image.asset(Images.login)]));
  }
}
