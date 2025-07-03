import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/dashboard_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/reusable/dialog.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class ProfileDashboardView extends StatelessWidget {
  const ProfileDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: bottomNavigationMenu(),
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              child: Column(
                children: [
                  headers(appname: "", showPrice: 1),
                  SizedBox(height: 6.r),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6.r)),
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 4.r), child: Text(textAlign: TextAlign.center, controller.list[controller.selectedIndex], style: TextStyle(color: Colors.white, fontSize: Dimensions.font16, fontFamily: TypographyResources.openSans))),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.r), child: _menueList(list: controller.list, controller: controller)),
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
                    showLogoutAlert(
                      onPressed: () {
                        controller.sharedPreferences.remove(Keys.loginData);
                        Get.offAllNamed(RoutesHelper.splash);
                      },
                      showCancelBtn: true,
                      description: LocalText.logoutDiscription,
                      buttonText: LocalText.logout,
                    );
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
