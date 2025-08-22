import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_controller.dart';
import 'package:quickb2b_v3_6/app/product/product_controller.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/response/categories_model.dart';
import 'package:quickb2b_v3_6/network/data/response/my_list_model.dart';
import 'package:quickb2b_v3_6/reusable/dialog.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation_controller.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class Navigation {
  String name;
  String iconUrl;
  String route;

  Navigation({required this.iconUrl, required this.name, required this.route});
}

Widget bottomNavigationMenu(BuildContext context) {
  return Container(
    decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 0.5))),
    height: 65.r,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  // controller.setSelectedIndex(0);
                  Get.find<ProductController>().page = 0;
                  Get.offNamed(RoutesHelper.home);
                },
                child: Column(
                  children: [
                    Image.asset(Images.home, height: 20.r),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontFamily: TypographyResources.openSans,
                        fontSize: 10.r,
                        // color: controller.bottomNavigationSelectedIndex == 0
                        //     ? ColorsResources.activeColor
                        //     : Colors.black,
                        fontWeight: FontWeight.w600,
                        // decoration: controller.bottomNavigationSelectedIndex == 0
                        //     ? TextDecoration.underline
                        //     : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  // controller.setSelectedIndex(1);

                  Get.find<ProductController>().page = 0;
                  Get.offNamed(RoutesHelper.myList);
                },
                child: Column(
                  children: [
                    Image.asset(Images.heart, height: 20.r),
                    Text(
                      "My List",
                      style: TextStyle(
                        fontFamily: TypographyResources.openSans,
                        fontSize: 10.r,
                        // color: controller.bottomNavigationSelectedIndex == 1
                        //     ? ColorsResources.activeColor
                        //     : Colors.black,
                        fontWeight: FontWeight.w600,
                        // decoration: controller.bottomNavigationSelectedIndex == 1
                        //     ? TextDecoration.underline
                        //     : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  // controller.setSelectedIndex(2);
                  Get.find<ProductController>().page = 0;
                  Get.offNamed(RoutesHelper.products);
                },
                child: Column(
                  children: [
                    Image.asset(Images.search, height: 20.r),
                    Text(
                      "Products",
                      style: TextStyle(
                        fontFamily: TypographyResources.openSans,
                        fontSize: 10.r,
                        // color: controller.bottomNavigationSelectedIndex == 2
                        //     ? ColorsResources.activeColor
                        //     : Colors.black,
                        fontWeight: FontWeight.w600,
                        // decoration: controller.bottomNavigationSelectedIndex == 2
                        //     ? TextDecoration.underline
                        //     : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  // controller.setSelectedIndex(3);
                  // Get.find<HomeController>().modifyingValOfX = 0;

                  Get.find<ProductController>().page = 0;
                  Get.offNamed(RoutesHelper.myOrder);
                },
                child: Column(
                  children: [
                    Image.asset(Images.cart, height: 20.r),
                    Text(
                      "My Order",
                      style: TextStyle(
                        fontFamily: TypographyResources.openSans,
                        fontSize: 10.r,
                        // color: controller.bottomNavigationSelectedIndex == 3
                        //     ? ColorsResources.activeColor
                        //     : Colors.black,
                        fontWeight: FontWeight.w600,
                        // decoration: controller.bottomNavigationSelectedIndex == 3
                        //     ? TextDecoration.underline
                        //     : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              // height: 60.r,
              child: GestureDetector(
                onTap: () {
                  // controller.setSelectedIndex(4);
                  // Get.find<HomeController>().modifyingValOfX = 0;

                  Get.find<ProductController>().page = 0;
                  Get.offNamed(RoutesHelper.account);
                },
                child: Column(
                  children: [
                    Image.asset(Images.user, height: 20.r),
                    Text(
                      "Account",
                      style: TextStyle(
                        fontFamily: TypographyResources.openSans,
                        fontSize: 10.r,
                        // color: controller.bottomNavigationSelectedIndex == 4
                        //     ? ColorsResources.activeColor
                        //     : Colors.black,
                        fontWeight: FontWeight.w600,
                        // decoration: controller.bottomNavigationSelectedIndex == 4
                        //     ? TextDecoration.underline
                        //     : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 25.r),
          child: Text("Devloped By QuickB2B", style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: 8.r, fontWeight: FontWeight.w400)),
        ),
      ],
    ),
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
                          Get.find<ProfileDashboardController>().logOut();
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

Widget categoryListMenu({required List<Category> list}) {
  return GetBuilder<NavigationController>(
    builder: (controller) {
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
                    controller.setSelectedTopNavigation(index);
                    Get.find<ProductController>().page = 0;
                    Get.find<ProductController>().searchProductByCategoryId(list[index].id ?? "");
                  },
                  child: _customText(text: list[index].name ?? "", isSelected: index == controller.topNavigationSelectedIndex),
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

Widget myListMenue({required List<DataWithCategory> list}) {
  return GetBuilder<MyListController>(
    builder: (controller) {
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
                    controller.setSelectedTopNavigation(index);
                    Get.find<ProductController>().page = 0;
                  },
                  child: _customText(text: list[index].categoryTitle ?? "", isSelected: index == controller.topNavigationIndex),
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
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          decorationColor: Colors.teal,
          decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
          fontFamily: TypographyResources.openSans,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.teal : Colors.black,
        ),
      ),
    ),
  );
}
