import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/network/data/response/cart_items_model.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

void itemsCountPopup(BuildContext context, {required String itemCode}) async {
  CartData? cart = await Get.find<LocalStorage>().getCartDetails();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 6.r),
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(decoration: BoxDecoration(border: Border.all(color: Colors.transparent)), child: Image.asset(Images.crossWhite, color: Colors.transparent)),
                  Flexible(child: Text("Beans Top Tailed-Order by KG", maxLines: 3, style: TextStyle(color: Colors.white))),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 6.r),
                      decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(6.r))),
                      child: Image.asset(Images.crossWhite, height: 12.r),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.r),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.black, size: 20.r),
                        SizedBox(width: 8.r),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.r, horizontal: 30.r),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5.r, strokeAlign: 1), borderRadius: BorderRadius.all(Radius.circular(2.r))),
                          child: Text("1", style: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(width: 8.r),
                        Icon(CupertinoIcons.multiply, color: Colors.grey, size: 20.r),
                        SizedBox(width: 8.r),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.r, horizontal: 30.r),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5.r, strokeAlign: 1), borderRadius: BorderRadius.all(Radius.circular(2.r))),
                          child: Text("1", style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey, thickness: 0.3),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
