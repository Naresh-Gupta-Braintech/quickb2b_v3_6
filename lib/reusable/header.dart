import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart' show Images;
import 'package:quickb2b_v3_6/utils/text_field.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget headers({required String appname, required int showPrice, String? rightText}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(appname, style: TextStyle(fontSize: Dimensions.font14, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold)),
      Visibility(
        visible: rightText != null && rightText.isEmpty,
        child: Row(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Visibility(visible: rightText == null, child: Image.asset(Images.cart, height: 35.r, fit: BoxFit.cover)),
                    Padding(padding: EdgeInsets.only(left: 10.r, bottom: 4.r), child: Text("0", style: TextStyle(color: Colors.red, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold, fontSize: Dimensions.font12))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      Visibility(visible: rightText != null, child: Text(rightText ?? "")),
      Visibility(visible: showPrice == 1 ? true : false, child: Text("Total \$0.00")),
    ],
  );
}

Widget headerWithSearch({bool showOutlet = true, VoidCallback? onTap, bool isSearchBarFull = false, int showPrice = 1, String? rightText, String? hint, TextAlign textAlignment = TextAlign.left}) {
  return Column(
    children: [
      Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: headers(appname: "", showPrice: showPrice ?? 0, rightText: rightText)),
      SizedBox(height: Dimensions.padding10),
      Padding(
        padding: EdgeInsets.only(bottom: 2.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customSearchBar(textController: TextEditingController(), isFull: isSearchBarFull, textAlignment: textAlignment, hint: hint),
            Visibility(visible: showOutlet, child: InkWell(onTap: onTap, child: Container(padding: EdgeInsets.all(7.r), decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Colors.black, width: 1)), child: Image.asset(Images.outlet, height: 19.r)))),
          ],
        ),
      ),
    ],
  );
}
