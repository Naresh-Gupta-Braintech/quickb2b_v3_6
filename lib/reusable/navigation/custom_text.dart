import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget selectedMenueText({required String text, required bool isSelected}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.r),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          decorationColor: Colors.teal,
          decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
          fontFamily: TypographyResources.openSans,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.teal : Colors.black,
        ),
      ),
    ),
  );
}
