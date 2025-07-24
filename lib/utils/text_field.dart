import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

Widget customTextField2({
  required TextEditingController controller,
  required String textFieldLabel,
  TextInputType? keyboardType,
  Color? borderColor,
  double? borderWidth,
  int? maxLine,
  double? height,
  double? width,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType ?? TextInputType.text,
    textAlignVertical: TextAlignVertical.center,
    cursorRadius: Radius.circular(50.r),
    cursorHeight: 12.r,
    decoration: InputDecoration(
      constraints: BoxConstraints(maxHeight: height ?? 30.r, maxWidth: width ?? Get.width),
      hintText: textFieldLabel,
      hintStyle: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400, color: Colors.grey),
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.padding10, vertical: 8.r),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(0),
      ),
    ),
    style: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400),
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

Widget customSearchBar({required TextEditingController textController, bool isFull = false, String? hint, required TextAlign textAlignment}) {
  return SizedBox(
    height: 39,
    width: isFull ? Get.width * 0.98 : Get.width / 1.19,
    child: TextFormField(
      controller: textController,
      textAlign: textAlignment,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        hintText: hint ?? "Search all products",
        prefixIcon: Icon(Icons.search, size: 20.r),
        hintStyle: TextStyle(fontFamily: TypographyResources.openSans),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black)),
        focusColor: Colors.black,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black)),
      ),
    ),
  );
}

Widget customTextFieldWithSuffix({
  required TextEditingController controller,
  required String textFieldLabel,
  TextInputType? keyboardType,
  required IconData icon,
}) {
  return TextField(
    keyboardType: keyboardType ?? TextInputType.text,
    textAlignVertical: TextAlignVertical.center,
    cursorRadius: Radius.circular(50.r),
    cursorHeight: 12.r,

    decoration: InputDecoration(
      constraints: BoxConstraints(maxHeight: 40.r),
      suffixIcon: Icon(icon),
      hintText: textFieldLabel,
      hintStyle: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400, color: Colors.grey),
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.padding10),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.5.r), borderRadius: BorderRadius.circular(0)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.5.r), borderRadius: BorderRadius.circular(0)),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.5.r), borderRadius: BorderRadius.circular(0)),
    ),
    style: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400),
  );
}

Widget customTextFieldWithWidthConstraint({
  required TextEditingController controller,
  required String textFieldLabel,
  TextInputType? keyboardType,
  Color? borderColor,
  double? borderWidth,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType ?? TextInputType.text,
    textAlignVertical: TextAlignVertical.center,
    textAlign: TextAlign.center,
    cursorRadius: Radius.circular(50.r),
    cursorHeight: 12.r,
    decoration: InputDecoration(
      constraints: BoxConstraints(maxHeight: 25.r, maxWidth: 60.r),
      hintText: textFieldLabel,
      hintStyle: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400, color: Colors.grey),
      contentPadding: EdgeInsets.only(top: 8.r),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(4.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(4.r),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(4.r),
      ),
    ),
    style: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400),
  );
}

Widget customTextFieldWithMaxLines({
  required TextEditingController controller,
  required String textFieldLabel,
  TextInputType? keyboardType,
  Color? borderColor,
  double? borderWidth,
  required int maxLine,
}) {
  return TextField(
    maxLines: maxLine,
    controller: controller,
    keyboardType: keyboardType ?? TextInputType.text,
    textAlignVertical: TextAlignVertical.center,
    cursorRadius: Radius.circular(50.r),
    cursorHeight: 12.r,
    decoration: InputDecoration(
      hintText: textFieldLabel,
      hintStyle: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400, color: Colors.grey),
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.padding10, vertical: 8.r),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.black, width: borderWidth ?? 1.r),
        borderRadius: BorderRadius.circular(0),
      ),
    ),
    style: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w400),
  );
}
