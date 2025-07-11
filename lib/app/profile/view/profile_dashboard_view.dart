import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_controller.dart';

import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation_controller.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';

import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class ProfileDashboardView extends StatelessWidget {
  const ProfileDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (navigationController) {
        return GetBuilder<ProfileDashboardController>(
          builder: (controller) {
            return Scaffold(
              bottomNavigationBar: bottomNavigationMenu(),
              backgroundColor: Colors.white,
              body: SafeArea(
                bottom: false,
                left: false,
                right: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.r),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding8), child: headers(appname: "develope", showPrice: 1)),
                      SizedBox(height: 6.r),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.padding8),
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6.r)),
                          child: Padding(padding: EdgeInsets.symmetric(vertical: 4.r), child: Text(textAlign: TextAlign.center, controller.list[controller.selectedIndex], style: TextStyle(color: Colors.white, fontSize: Dimensions.font16, fontFamily: TypographyResources.openSans))),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10.r), child: menueList(list: controller.list)),
                      Expanded(child: controller.changePage(navigationController.topNavigationSelectedIndex)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _customText({required String text, required bool isSelected}) {
    return Container(padding: EdgeInsets.symmetric(horizontal: 4.r), child: Center(child: Text(text, style: TextStyle(decoration: isSelected ? TextDecoration.underline : TextDecoration.none, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w600))));
  }
}
