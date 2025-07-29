import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_controller.dart';
import 'package:quickb2b_v3_6/network/data/response/past_order_model.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class PastOrder extends StatefulWidget {
  const PastOrder({super.key});

  @override
  State<PastOrder> createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrder> {
  @override
  void initState() {
    super.initState();
    Get.find<ProfileDashboardController>().getPastOrders();
  }

  @override
  Widget build(BuildContext context) {
    double width = Get.width - 16;
    return GetBuilder<ProfileDashboardController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.padding8),
              child: Column(
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
                                columnWidths: {0: FixedColumnWidth((Get.width) / 5), 1: FixedColumnWidth(width / 5), 2: FixedColumnWidth(width / 5), 3: FixedColumnWidth(width / 5)},
                                border:  TableBorder.symmetric(inside: BorderSide.none, outside: BorderSide.none),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                    children: [_customText(LocalText.order), _customText(LocalText.date), _customText(LocalText.delivered), _customText(LocalText.status), _customText(LocalText.reorder)],
                                  ),
                                  for (Order order in controller.pastOrder?.data ?? <Order>[])
                                    TableRow(
                                      children: [
                                        _customText(order.orderId ?? "", color: Colors.green[600]),
                                        _customText(order.orderDate ?? "", color: Colors.black),
                                        _customText(order.deliveryDate ?? "", color: Colors.black),
                                        _customText(order.status ?? "", color: Colors.black),
                                        Image.asset(Images.reorder, height: 20.r),
                                        // _customText("" ?? "", color: Colors.black),
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
          ),
        );
      },
    );
  }

  Widget _customText(String text, {Color? color, FontWeight? fontWeight}) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 4.r), child: Text(text, style: TextStyle(color: color ?? Colors.white, fontSize: 11.r, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w400), textAlign: TextAlign.center));
  }
}
