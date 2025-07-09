import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Images.linkBackground, fit: BoxFit.cover),
          Column(children: [_subHeading(text: "Our Website")]),
        ],
      ),
    );
  }

  Widget _subHeading({required String text}) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(padding: EdgeInsets.symmetric(vertical: 8.r), child: Text(textAlign: TextAlign.center, text.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: Dimensions.font14, fontFamily: TypographyResources.openSans))),
    );
  }
}
