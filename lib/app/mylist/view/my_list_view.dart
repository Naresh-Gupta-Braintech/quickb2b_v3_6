import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_controller.dart';
import 'package:quickb2b_v3_6/app/product/product_controller.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/loader.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/reusable/products.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _MyListState();
}

class _MyListState extends State<MyListView> {
  @override
  void initState() {
    super.initState();
    Get.find<MyListController>().getUserData(0);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyListController>(
      builder: (mylistController) {
        final menuList = mylistController.myList?.dataWithCategory ?? [];
        print(menuList.length);
        return GetBuilder<HomeController>(
          builder: (controller) {
            var bannersList = controller.homeItems?.data?.bannerLists ?? [];
            return GetBuilder<ProductController>( 
              builder: (productController) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  bottomNavigationBar: bottomNavigationMenu(),
                  body: SafeArea(
                    child:
                        mylistController.loading
                            ? customLoader()
                            : Column(
                              children: [
                                headerWithSearch(hint: "Search all products", appName: controller.homeItems?.appName ?? ""),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        physics: NeverScrollableScrollPhysics(),
                                        child: Column(
                                          children: [
                                            Visibility(
                                              visible: (controller.homeItems?.showAppBanner == 1 && bannersList.isNotEmpty) ? true : false,
                                              child: Padding(padding: EdgeInsets.only(top: 5.r), child: customCarousel(width: Get.width, height: 130.r, images: controller.homeItems?.data?.bannerLists ?? [])),
                                            ),
                                            SizedBox(height: 6.r),
                                            myListMenue(list: menuList),
                                            SizedBox(height: 6.r),

                                            //list view
                                            SizedBox(
                                              height: Get.height - (65.r + 90.r),
                                              width: Get.width,
                                              child: ListView.builder(
                                                physics: const ClampingScrollPhysics(),

                                                itemCount: productController.productsInventry.length,
                                                itemBuilder: (context, index) {
                                                  String showImage = productController.productdata?.showImage ?? "";
                                                  return Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 4.r),
                                                    child: horizontalProduct(
                                                      onTap: () {},
                                                      url: productController.productsInventry[index]?.image ?? "",
                                                      price: productController.productsInventry[index]?.itemPrice ?? "",
                                                      name: productController.productsInventry[index]?.itemName ?? "",
                                                      isMeasBox: productController.productsInventry[index]?.isMeasBox ?? 0,
                                                      hint: productController.productsInventry[index]?.uom ?? "",
                                                      isShowImage: showImage.trim().isNotEmpty ? int.tryParse(showImage) ?? 0 : 0,
                                                      controller1: TextEditingController(),
                                                      controller2: TextEditingController(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(visible: controller.toggleOutlet, child: _outlets(controller)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _outlets(HomeController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 6.r, right: 6.r, top: 0.r),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(4.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding6, vertical: Dimensions.padding6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(bottom: Dimensions.padding8), child: Text("Select the outlet to place an order", style: TextStyle(color: Colors.grey, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w600))),
              for (int i = 0; i < controller.outlets.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.padding8),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(controller.outlets[i], style: TextStyle(fontFamily: TypographyResources.openSans)), Visibility(visible: controller.selectedOutlet == i, child: Image.asset(Images.rightTale))]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
