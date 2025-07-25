import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget customButton({required String textLabel, required VoidCallback onPressed}) {
  return Container(
    height: Dimensions.viewHeight30,
    width: Get.width / 2.2,
    margin: EdgeInsets.symmetric(),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white.withAlpha(100)),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.withAlpha(125)),
      onPressed: onPressed,
      child: Text(textLabel, style: TextStyle(color: Colors.black, fontSize: Dimensions.font16, fontFamily: 'AcuminRegular')),
    ),
  );
}

Widget customButton2({
  required String textLabel,
  required double width,
  required Color color,
  required VoidCallback onPressed,
  double? height,
  double? fontSize,
}) {
  return Container(
    height: height ?? Dimensions.viewHeight30,
    width: width,
    margin: EdgeInsets.symmetric(),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: color),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: Text(
        textLabel,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? Dimensions.font12,
          fontFamily: TypographyResources.acumin,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget customRadioButton({required List<String> labels, required List<String> values}) {
  return Column(
    children: [
      for (int i = 0; i < labels.length; i++)
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
          minVerticalPadding: 0,
          horizontalTitleGap: 0,
          title: Text(labels[i], style: TextStyle(color: Colors.green, fontSize: Dimensions.font14)),
          leading: Radio(value: values[i], groupValue: 'selected', onChanged: (value) {}),
        ),
    ],
  );
}

Widget customCheckedBox({required String text}) {
  return ListTileTheme(
    horizontalTitleGap: 0,
    child: CheckboxListTile(
      contentPadding: EdgeInsets.only(top: 0, left: 0),
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(text, style: TextStyle(color: Colors.black)),
      value: false,
      activeColor: Colors.black,
      onChanged: (bool? value) {},
    ),
  );
}
