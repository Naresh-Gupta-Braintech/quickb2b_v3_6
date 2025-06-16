import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget customTextField({required TextEditingController controller, required String textFieldLabel}) {
  return Container(
    height: Dimensions.viewHeight30,
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
    height: Dimensions.viewHeight30,
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

Widget customTextField2({required TextEditingController controller, required String textFieldLabel, TextInputType? keyboardType}) {
  return SizedBox(
    height: 35.r,
    child: TextField(
      keyboardType: keyboardType ?? TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: textFieldLabel,
        hintStyle: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.padding10),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.r), borderRadius: BorderRadius.circular(0)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.r), borderRadius: BorderRadius.circular(0)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.r), borderRadius: BorderRadius.circular(0)),
      ),
      style: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400),
    ),
  );
}

Widget dropDown({required List<String> items}) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    height: 35.r,
    child: DropdownButton<String>(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.padding10),
      underline: SizedBox.shrink(),
      isExpanded: true,
      hint: Text(
        'Select Region',
        style: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400, color: Colors.grey),
      ),
      items:
          items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              alignment: Alignment.center,
              value: value,
              child: Text(
                textAlign: TextAlign.center,
                value,
                style: TextStyle(
                  fontSize: Dimensions.font12,
                  fontFamily: TypographyResources.acumin,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
      onChanged: (String? newValue) {},
    ),
  );
}
