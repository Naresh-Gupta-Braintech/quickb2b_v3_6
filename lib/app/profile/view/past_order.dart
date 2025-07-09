import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/view/order_model.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class PastOrder extends StatelessWidget {
  const PastOrder({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width - 16;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Main View
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16.r),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Table(
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          columnWidths: {0: FixedColumnWidth((Get.width) / 5), 1: FixedColumnWidth(width / 5), 2: FixedColumnWidth(width / 5), 3: FixedColumnWidth(width / 5), 4: FixedColumnWidth(width / 5)},
                          border: const TableBorder.symmetric(inside: BorderSide.none, outside: BorderSide.none),
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(4.r))),
                              children: [_customText(LocalText.order), _customText(LocalText.date), _customText(LocalText.delivered), _customText(LocalText.status), _customText(LocalText.reorder)],
                            ),
                            for (var user in orderData)
                              TableRow(
                                children: [
                                  _customText(user.order ?? "", color: Colors.green[600]),
                                  _customText(user.date ?? "", color: Colors.black),
                                  _customText(user.delivered ?? "", color: Colors.black),
                                  _customText(user.status ?? "", color: Colors.black),
                                  _customText(user.reorder ?? "", color: Colors.black),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Progress Indicator
            Visibility(
              visible: false, // Change to true to show
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customText(String text, {Color? color, FontWeight? fontWeight}) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 4.r), child: Text(text, style: TextStyle(color: color ?? Colors.white, fontSize: 11.r, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w400), textAlign: TextAlign.center));
  }
}
