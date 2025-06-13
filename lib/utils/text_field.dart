import 'package:flutter/material.dart';

Widget customTextField({required TextEditingController controller, required String textFieldLabel}) {
  return Container(
    height: 30,
    margin: EdgeInsets.symmetric(horizontal: 50),
    decoration: BoxDecoration(color: Colors.white.withAlpha(220)),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(hintText: textFieldLabel, hintStyle: TextStyle(color: Color(0xFF696969)), border: InputBorder.none),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
    ),
  );
}

Widget customObsecureTextField({required TextEditingController controller, required String textFieldLabel, required bool obsecureText}) {
  return Container(
    height: 30,
    margin: EdgeInsets.symmetric(horizontal: 50),
    decoration: BoxDecoration(color: Colors.white.withAlpha(220)),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(hintText: textFieldLabel, hintStyle: TextStyle(color: Color(0xFF696969)), border: InputBorder.none),
      obscureText: obsecureText,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
    ),
  );
}
