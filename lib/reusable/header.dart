import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart' show Images;
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget headers() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(LocalText.develop, style: TextStyle(fontSize: Dimensions.font14, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold)),
      Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [Image.asset(Images.cart, height: 35.r, fit: BoxFit.cover), Padding(padding: EdgeInsets.only(left: 10.r, bottom: 4.r), child: Text("0", style: TextStyle(color: Colors.red, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold, fontSize: Dimensions.font12)))],
          ),

          Text("Total \$0.00"),
        ],
      ),
    ],
  );
}
