import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart' show Images;
import 'package:quickb2b_v3_6/utils/text_field.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget headers({required String appname, required int showPrice, String? rightText}) {
  return GetBuilder<CartController>(
    builder: (cartController) {
      var orders = cartController.cartData?.data?.allInventories ?? [];
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(appname, style: TextStyle(fontSize: Dimensions.font14, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold)),
          Visibility(
            visible: rightText == null || rightText.isEmpty,
            replacement: Text(rightText ?? ""),
            child: Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.offNamed(RoutesHelper.myOrder);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Visibility(visible: rightText == null || rightText.isEmpty, child: Image.asset(Images.cart, height: 35.r, fit: BoxFit.cover)),
                          Padding(
                            padding: EdgeInsets.only(left: 10.r, bottom: 4.r),
                            child: Text(
                              orders.length.toString(),
                              style: TextStyle(color: Colors.red, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold, fontSize: Dimensions.font12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6.r),
                    Visibility(
                      visible: showPrice == 1 ? true : false,
                      child: Text(
                        "Total ${cartController.cartData?.currencySymbol ?? ""}${cartController.cartPrice}",
                        style: TextStyle(fontSize: Dimensions.font16, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ), //(rightText != null && rightText.isNotEmpty)
          // Visibility(visible: true, child: Text(rightText ?? "hellos")),
        ],
      );
    },
  );
}

Widget headerWithSearch({
  bool showOutlet = true,
  bool isSearchBarFull = false,
  int showPrice = 1,
  String? rightText,
  String? hint,
  TextAlign textAlignment = TextAlign.left,
  required String appName,
}) {
  return SizedBox(
    height: 85.r,
    child: Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: headers(appname: appName, showPrice: showPrice ?? 0, rightText: rightText)),
        SizedBox(height: Dimensions.padding10),
        Padding(
          padding: EdgeInsets.only(bottom: 0.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customSearchBar(textController: TextEditingController(), isFull: isSearchBarFull, textAlignment: textAlignment, hint: hint),
              Visibility(
                visible: showOutlet,
                child: GestureDetector(
                  onTap: () {
                    Get.find<HomeController>().updateToggleOutlet();
                  },
                  child: Container(
                    height: 38.r,
                    padding: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Colors.black, width: 1)),
                    child: Image.asset(Images.outlet, height: 19.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
