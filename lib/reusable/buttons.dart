import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customButton({required String textLabel}) {
  return Container(
    height: 30,
    width: Get.width / 2.2,
    margin: EdgeInsets.symmetric(),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white.withAlpha(100)),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.withAlpha(125)),
      onPressed: () {},
      child: Text(textLabel, style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'AcuminRegular')),
    ),
  );
}
