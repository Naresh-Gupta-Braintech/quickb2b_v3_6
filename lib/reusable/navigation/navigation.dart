import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation_controller.dart';
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
                            style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: 10.r, color: controller.selectedIndex == i ? Colors.green[300] : Colors.black, fontWeight: FontWeight.w600, decoration: controller.selectedIndex == i ? TextDecoration.underline : TextDecoration.none),
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
