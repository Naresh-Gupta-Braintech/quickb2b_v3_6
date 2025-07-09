import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/reusable/dialog.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation_controller.dart';
import 'package:quickb2b_v3_6/utils/colors_resources.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class Navigation {
  String name;
  String iconUrl;
  String route;

  Navigation({required this.iconUrl, required this.name, required this.route});
}

Widget bottomNavigationMenu() {
  return GetBuilder<NavigationController>(
    builder: (controller) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black, // change to your desired color
              width: 0.5, // change to your desired width
            ),
          ),
        ),
        height: 65.r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < controller.bottomNavigation.length; i++)
                  SizedBox(
                    // height: 60.r,
                    child: GestureDetector(
                      onTap: () {
                        // controller.setSelectedIndex(i);
                        Get.offNamed(controller.bottomNavigation[i].route);
                      },
                      child: Column(
                        children: [
                          Image.asset(controller.bottomNavigation[i].iconUrl, height: 20.r),
                          Text(
                            controller.bottomNavigation[i].name,
                            style: TextStyle(
                              fontFamily: TypographyResources.openSans,
                              fontSize: 10.r,
                              color: controller.selectedIndex == i ? ColorsResources.activeColor : Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: controller.selectedIndex == i ? TextDecoration.underline : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(padding: EdgeInsets.only(right: 25.r), child: Text("Devloped By QuickB2B", style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: 8.r, fontWeight: FontWeight.w400))),
          ],
        ),
      );
    },
  );
}

Widget menueList({required List<String> list}) {
  return GetBuilder<NavigationController>(
    builder: (controller) {
      return SizedBox(
        height: 20.r,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            print("index :: $index");
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
                          controller.sharedPreferences.remove(Keys.acmCode);
                          Get.offNamed(RoutesHelper.splash);
                        },
                        showCancelBtn: true,
                        description: LocalText.logoutDiscription,
                        buttonText: LocalText.logout,
                      );
                      return;
                    }
                    controller.setSelectedTopNavigation(index);
                  },
                  child: _customText(text: list[index], isSelected: index == controller.topNavigationSelectedIndex),
                ),

                Visibility(visible: list.length - 1 != index, child: Text("|")),
              ],
            );
          },
        ),
      );
    },
  );
}

Widget _customText({required String text, required bool isSelected}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.r),
    child: Center(child: Text(text, style: TextStyle(decorationColor: Colors.teal, decoration: isSelected ? TextDecoration.underline : TextDecoration.none, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w600, color: isSelected ? Colors.teal : Colors.black))),
  );
}
