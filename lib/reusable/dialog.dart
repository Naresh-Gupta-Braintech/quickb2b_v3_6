import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

showAlert({required VoidCallback onPressed, required bool showCancelBtn, required String description, required String buttonText}) {
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: Colors.black,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(20.r),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
        content: Container(
          padding: EdgeInsets.all(10.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.r)), border: Border.all(color: Colors.white)),
                    child: Padding(padding: EdgeInsets.all(4.r), child: GestureDetector(onTap: () => Get.back(), behavior: HitTestBehavior.opaque, child: Image.asset(Images.crossWhite, height: 8.r))),
                  ),
                ],
              ),
              SizedBox(height: 20.r),
              Text(description, textAlign: TextAlign.center, style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font12, fontWeight: FontWeight.w500, color: Colors.white)),
              SizedBox(height: 10.r),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showCancelBtn)
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(LocalText.cancel, style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font12, fontWeight: FontWeight.w400, color: Colors.red)),
                    ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      onPressed();
                    },
                    child: Text(buttonText, style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font14, fontWeight: FontWeight.w400, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

showLogoutAlert({required VoidCallback onPressed, required bool showCancelBtn, required String description, required String buttonText}) {
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: Colors.black,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(10.r),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
        content: Container(
          padding: EdgeInsets.all(10.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.r)), border: Border.all(color: Colors.white)),
                    child: Padding(padding: EdgeInsets.all(4.r), child: GestureDetector(onTap: () => Get.back(), behavior: HitTestBehavior.opaque, child: Image.asset(Images.crossWhite, height: 8.r))),
                  ),
                ],
              ),
              SizedBox(height: 20.r),
              Text(description, textAlign: TextAlign.center, style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font12, fontWeight: FontWeight.w500, color: Colors.white)),
              SizedBox(height: 10.r),
              TextButton(
                onPressed: () {
                  Get.back();
                  onPressed();
                },
                child: Text(buttonText, style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font14, fontWeight: FontWeight.w400, color: Colors.white)),
              ),
              if (showCancelBtn)
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(LocalText.cancel, style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font12, fontWeight: FontWeight.w400, color: Colors.white)),
                ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
