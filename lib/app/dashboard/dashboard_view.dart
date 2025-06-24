import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/dashboard/dashboard_controller.dart';
import 'package:quickb2b_v3_6/reusable/dialog.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocalText.develop, style: TextStyle(fontSize: Dimensions.font14, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold)),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(Images.cart, height: 35.r, fit: BoxFit.cover),
                              Padding(padding: EdgeInsets.only(left: 10.r, bottom: 4.r), child: Text("0", style: TextStyle(color: Colors.red, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold, fontSize: Dimensions.font12))),
                            ],
                          ),

                          Text("Total \$0.00"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.r),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6.r)),
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 4.r), child: Text(textAlign: TextAlign.center, controller.list[controller.selectedIndex], style: TextStyle(color: Colors.white, fontSize: Dimensions.font16, fontFamily: TypographyResources.openSans))),
                  ),
                  _menueList(list: controller.list, controller: controller),
                  Expanded(child: controller.changePage()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _menueList({required List<String> list, required DashboardController controller}) {
    return SizedBox(
      height: 20.r,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (index == 4) {
                    showAlert(onPressed: () {}, showCancelBtn: true, description: LocalText.resetListDescription, buttonText: LocalText.confirm);
                    return;
                  }
                  if (index == 5) {
                    showLogoutAlert(onPressed: () {}, showCancelBtn: true, description: LocalText.logoutDiscription, buttonText: LocalText.logout);
                    return;
                  }
                  controller.updateIndex(index);
                },
                child: _customText(text: list[index], isSelected: false),
              ),

              Visibility(visible: list.length - 1 != index, child: Text("|")),
            ],
          );
        },
      ),
    );
  }

  Widget _customText({required String text, required bool isSelected}) {
    return Container(padding: EdgeInsets.symmetric(horizontal: 4.r), child: Center(child: Text(text, style: TextStyle(decoration: isSelected ? TextDecoration.underline : TextDecoration.none, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w600))));
  }
}
