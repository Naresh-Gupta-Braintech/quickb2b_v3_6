import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_dataservice.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_controller.dart';
import 'package:quickb2b_v3_6/network/data/response/outlet_data.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/loader.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/reusable/products_component.dart';
import 'package:quickb2b_v3_6/utils/colors_resources.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    Get.find<HomeController>().gethomeItems();
  }

  @override
  void dispose() {
    super.dispose();
    unawaited(Get.find<HomeController>().updateUserInventoryHome());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        var bannersList = controller.homeItems?.data?.bannerLists ?? [];
        var categoriesList = controller.homeItems?.data?.allCategories ?? [];
        var allInventories = controller.homeItems?.data?.allInventories ?? [];
        var specialInventories = controller.homeItems?.data?.specialInventories ?? [];
        return GetBuilder<AuthController>(
          builder: (authController) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                bottom: false,
                child:
                    controller.loading || controller.outletLoading
                        ? customLoader()
                        : Padding(
                          padding: EdgeInsets.only(bottom: 0.r),
                          child: Column(
                            children: [
                              headerWithSearch(appName: controller.homeItems?.appName ?? ""),
                              Expanded(
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Visibility(
                                            visible: (controller.homeItems?.showAppBanner == 1 && bannersList.isNotEmpty) ? true : false,
                                            child: Padding(padding: EdgeInsets.only(top: 5.r), child: customCarousel(width: Get.width, height: 130.r, images: bannersList)),
                                          ),
                                          SizedBox(height: Dimensions.padding16),

                                          // search by category
                                          Visibility(
                                            visible: (controller.homeItems?.data?.categoryExists == 1 && categoriesList.isNotEmpty),
                                            child: Column(
                                              children: [
                                                Padding(padding: EdgeInsets.symmetric(horizontal: 3.r), child: _customSubHeading(text: "Search by Categories", buttonText: "See All")),
                                                SizedBox(height: 8.r),
                                                SizedBox(
                                                  height: 106.r,
                                                  child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: controller.homeItems?.data?.allCategories?.length,
                                                    itemBuilder: (context, index) {
                                                      return Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 3.r),
                                                        child: categoryWidget(
                                                          url: controller.homeItems?.data?.allCategories?[index].thumbImage ?? "",
                                                          text: controller.homeItems?.data?.allCategories?[index].name ?? "",
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // special Items
                                          SizedBox(height: 16.r),
                                          Visibility(
                                            visible: specialInventories.isNotEmpty,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 3.r),
                                                  child: _customSubHeading(text: controller.homeItems?.specialHeaderTitle ?? "", buttonText: "See All"),
                                                ),
                                                SizedBox(height: 8.r),
                                                Visibility(
                                                  child: SizedBox(
                                                    height: 235.r,
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: controller.homeItems?.data?.allInventories?.length,
                                                      itemBuilder: (context, index) {
                                                        return Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 3.r),
                                                          child: specialProducts(
                                                            controller2: controller.myListControllers[index][1] ?? TextEditingController(),
                                                            controller1: controller.myListControllers[index][0] ?? TextEditingController(),
                                                            url: controller.homeItems?.data?.specialInventories?[index].image ?? "",
                                                            price: controller.homeItems?.data?.specialInventories?[index].itemPrice ?? "",
                                                            name: controller.homeItems?.data?.specialInventories?[index].itemName ?? "",
                                                            isMeasBox: controller.homeItems?.data?.specialInventories?[index].isMeasBox ?? 0,
                                                            hint: "",
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 16.r),
                                              ],
                                            ),
                                          ),
                                          //products List
                                          Visibility(
                                            visible: (controller.homeItems?.showMyProduct == 1 && allInventories.isNotEmpty),
                                            child: Column(
                                              children: [
                                                Padding(padding: EdgeInsets.symmetric(horizontal: 3.r), child: _customSubHeading(text: "My Products List", buttonText: "See All")),
                                                SizedBox(height: 8.r),
                                                Visibility(
                                                  child: SizedBox(
                                                    height: 225.r,
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: controller.homeItems?.data?.allInventories?.length,
                                                      itemBuilder: (context, index) {
                                                        return Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 3.r),
                                                          child: verticalProduct(
                                                            onTapHyphen: () {
                                                              Get.find<MyListController>().removeFromList(controller.homeItems?.data?.allInventories?[index].itemCode ?? "");
                                                            },
                                                            context: context,
                                                            product: controller.homeItems?.data?.allInventories?[index] ?? Product(),
                                                            onTapPlusIcon: () {
                                                              controller.onTapPlusIconforMultiItem(index);
                                                            },
                                                            onChanged: (value) {
                                                              controller.onChagedHomeProduct(index);
                                                            },
                                                            isShowImage: int.tryParse(controller.homeItems?.showImage ?? "0") ?? 0,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: productOfProductList(url: "https://develop.quickb2b.com/files/inventory/QuickB2B_Develop/1658124745no-image-available.png")),
                                          SizedBox(height: Dimensions.padding16),
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 3.r), child: _customSubHeading(text: "Featured", buttonText: "")),
                                          SizedBox(height: Dimensions.padding10),
                                          Image.asset(Images.featuredGradient, width: Get.width, fit: BoxFit.cover),
                                          SizedBox(height: Dimensions.padding10),
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 3.r), child: HtmlWidget(controller.homeItems?.data?.featuredItemImage?.content ?? "")),
                                        ],
                                      ),
                                    ),
                                    Visibility(visible: controller.toggleOutlet, child: _outlets(controller)),
                                  ],
                                ),
                              ),
                              bottomNavigationMenu(context),
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

  Widget _customSubHeading({required String text, required String buttonText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontFamily: TypographyResources.openSans)),
        GestureDetector(onTap: () {}, child: Text(buttonText, style: TextStyle(color: Colors.grey, fontSize: 10.r))),
      ],
    );
  }

  // outlets
  Widget _outlets(HomeController controller) {
    OutletData? outletsData = Get.find<LocalStorage>().getOutlets();
    var selectedOutlet = Get.find<LocalStorage>().getSelectedOutlets();
    var length = outletsData?.data?.length ?? 0;
    print("selected Outlet ::${selectedOutlet?.name}");

    return Padding(
      padding: EdgeInsets.only(left: 4.r, right: 4.r),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(4.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.padding6, left: Dimensions.padding6, right: Dimensions.padding6, top: Dimensions.padding6),
                child: Text("Select the outlet to place an order", style: TextStyle(color: Colors.grey, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w600)),
              ),
              for (int i = 0; i < length; i++)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    await controller.sharedPreferences.setString(Keys.userCode, outletsData?.data?[i].userCode ?? "");
                    await Get.find<LocalStorage>().saveSelectedOutlet(outletsData?.data?[i]);
                    controller.toggleOutlet = false;
                    await Get.find<AuthController>().getDevice();
                    await Get.find<CartController>().getCart();
                    controller.gethomeItems();
                    setState(() {});
                  },
                  child: Container(
                    color: selectedOutlet?.name == outletsData?.data?[i].name ? ColorsResources.grey : Colors.grey.shade300,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.padding10, horizontal: Dimensions.padding6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            outletsData?.data?[i].name ?? "",
                            style: TextStyle(
                              fontSize: 15.r,
                              fontWeight: FontWeight.w100,
                              fontFamily: TypographyResources.openSans,
                              color: selectedOutlet?.name == outletsData?.data?[i].name ? ColorsResources.activeOutlet : Colors.black,
                            ),
                          ),
                          Visibility(visible: selectedOutlet?.name == outletsData?.data?[i].name, child: Image.asset(Images.rightTale)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
