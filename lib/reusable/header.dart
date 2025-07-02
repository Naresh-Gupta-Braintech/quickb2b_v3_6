import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart' show Images;
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget headers({required String appname, required int showPrice}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(appname, style: TextStyle(fontSize: Dimensions.font14, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold)),
      Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [Image.asset(Images.cart, height: 35.r, fit: BoxFit.cover), Padding(padding: EdgeInsets.only(left: 10.r, bottom: 4.r), child: Text("0", style: TextStyle(color: Colors.red, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold, fontSize: Dimensions.font12)))],
          ),

          Visibility(visible: showPrice == 1 ? true : false, child: Text("Total \$0.00")),
        ],
      ),
    ],
  );
}
