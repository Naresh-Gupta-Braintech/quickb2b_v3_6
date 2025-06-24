import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class LinksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Images.linkBackground, fit: BoxFit.cover),
          Column(
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(color: Colors.black),
                child: Padding(padding: EdgeInsets.symmetric(vertical: 4.r), child: Text(textAlign: TextAlign.center, "Our Website".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: Dimensions.font12, fontFamily: TypographyResources.openSans))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
