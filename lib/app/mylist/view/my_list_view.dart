import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_controller.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_data_service.dart';
import 'package:quickb2b_v3_6/app/product/product_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
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
  int? selectedIndex;
  @override
  void initState() {
    super.initState();
    String previousRoute = Get.previousRoute;
    Get.find<MyListController>().getUserData(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesHelper.home);
        return false;
      },
      child: GetBuilder<MyListController>(
        builder: (mylistController) {
          return GetBuilder<HomeController>(
            builder: (controller) {
              var bannersList = controller.homeItems?.data?.bannerLists ?? [];
              return GetBuilder<ProductController>(
                builder: (productController) {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: SafeArea(
                      bottom: false,
                      child:
                          mylistController.loading
                              ? customLoader()
                              : Stack(
                                children: [
                                  Column(
                                    children: [
                                      headerWithSearch(
                                        hint: "Search all products",
                                        appName: controller.homeItems?.appName ?? "",
                                      ),
                                      Visibility(
                                        visible:
                                            (controller.homeItems?.showAppBanner == 1 &&
                                                    bannersList.isNotEmpty)
                                                ? true
                                                : false,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 5.r),
                                          child: customCarousel(
                                            width: Get.width,
                                            height: 130.r,
                                            images: controller.homeItems?.data?.bannerLists ?? [],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 6.r),
                                      myListMenue(list: mylistController.dataWithCategory ?? []),
                                      SizedBox(height: 6.r),
                                      mylistController.myList?.showItemInGridView == 0
                                          ?
                                          //list view
                                          Expanded(
                                            child: SizedBox(
                                              height: Get.height,
                                              child: ReorderableListView.builder(
                                                onReorder: (oldIndex, newIndex) {
                                                  final list =
                                                      mylistController
                                                          .dataWithCategory?[mylistController
                                                              .topNavigationIndex]
                                                          .data;
                                                  if (list == null) return;
                                                  if (newIndex > oldIndex) newIndex -= 1;
                                                  final item = list.removeAt(oldIndex);
                                                  list.insert(newIndex, item);
                                                  mylistController.update();
                                                },
                                                physics: const ClampingScrollPhysics(),
                                                itemCount:
                                                    mylistController
                                                        .dataWithCategory?[mylistController
                                                            .topNavigationIndex]
                                                        .data
                                                        ?.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  String showImage =
                                                      mylistController.myList?.showImage ?? "";
                                                  final products =
                                                      mylistController
                                                          .dataWithCategory?[mylistController
                                                          .topNavigationIndex];
                                                  return Container(
                                                    key: ValueKey(index),
                                                    padding: EdgeInsets.symmetric(vertical: 4.r),
                                                    child: horizontalProduct(
                                                      icon: Images.hyphenInsideCircle,
                                                      onTapIcon: () {
                                                        mylistController.removeFromMyList(
                                                          mylistController
                                                                  .dataWithCategory?[mylistController
                                                                      .topNavigationIndex]
                                                                  .data?[index]
                                                                  .itemCode ??
                                                              "",
                                                        );
                                                      },
                                                      onTap: () {},
                                                      onChanged: (value) {
                                                        print("product id myList :: ${value}");
                                                        if (products?.data?[index].isMeasBox == 0) {
                                                          controller.onChaged(
                                                            mylistController
                                                                .dataWithCategory?[mylistController
                                                                    .topNavigationIndex]
                                                                .data?[index]
                                                                .textEditingController2,
                                                            index,
                                                          );
                                                        } else {
                                                          controller.onChaged(
                                                            mylistController
                                                                .dataWithCategory?[mylistController
                                                                    .topNavigationIndex]
                                                                .data?[index]
                                                                .textEditingController1,
                                                            index,
                                                          );
                                                          controller.onChaged(
                                                            mylistController
                                                                .dataWithCategory?[mylistController
                                                                    .topNavigationIndex]
                                                                .data?[index]
                                                                .textEditingController2,
                                                            index,
                                                          );
                                                        }
                                                      },
                                                      url: products?.data?[index].image ?? "",
                                                      price: products?.data?[index].itemPrice ?? "",
                                                      name: products?.data?[index].itemName ?? "",
                                                      isMeasBox:
                                                          products?.data?[index].isMeasBox ?? 0,
                                                      hint: products?.data?[index].uom ?? "",
                                                      isShowImage:
                                                          showImage.trim().isNotEmpty
                                                              ? int.tryParse(showImage) ?? 0
                                                              : 0,
                                                      controller1:
                                                          mylistController
                                                              .dataWithCategory?[mylistController
                                                                  .topNavigationIndex]
                                                              .data?[index]
                                                              .textEditingController1 ??
                                                          TextEditingController(),
                                                      controller2:
                                                          mylistController
                                                              .dataWithCategory?[mylistController
                                                                  .topNavigationIndex]
                                                              .data?[index]
                                                              .textEditingController2 ??
                                                          TextEditingController(),
                                                      originQty:
                                                          products?.data?[index].originQty ?? "",
                                                      measureQty:
                                                          products?.data?[index].measureQty ?? "",
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                          :
                                          //Grid view
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 4.r),
                                              child: SizedBox(
                                                height: Get.height - (65.r + 60.r),
                                                child: DynamicHeightGridView(
                                                  physics: const ClampingScrollPhysics(),
                                                  builder: (context, index) {
                                                    String showImage =
                                                        productController.productdata?.showImage ??
                                                        "";
                                                    final products =
                                                        mylistController
                                                            .dataWithCategory?[mylistController
                                                            .topNavigationIndex];
                                                    return verticalProduct(
                                                      originQty:
                                                          productController
                                                              .productsInventry[index]
                                                              ?.originQty ??
                                                          "",
                                                      measureQty:
                                                          productController
                                                              .productsInventry[index]
                                                              ?.measureQty ??
                                                          "",
                                                      url:
                                                          productController
                                                              .productsInventry[index]
                                                              ?.image ??
                                                          "",
                                                      price:
                                                          productController
                                                              .productsInventry[index]
                                                              ?.itemPrice ??
                                                          "",
                                                      name:
                                                          productController
                                                              .productsInventry[index]
                                                              ?.itemName ??
                                                          "",
                                                      isMeasBox:
                                                          productController
                                                              .productsInventry[index]
                                                              ?.isMeasBox ??
                                                          0,
                                                      hint:
                                                          productController
                                                              .productsInventry[index]
                                                              ?.uom ??
                                                          "",
                                                      isShowImage:
                                                          showImage.trim().isNotEmpty
                                                              ? int.tryParse(showImage) ?? 0
                                                              : 0,
                                                      controller1: TextEditingController(),
                                                      controller2: TextEditingController(),
                                                      onChanged: (value) {
                                                        if (products?.data?[index].isMeasBox == 0) {
                                                          controller.onChaged(
                                                            products
                                                                ?.data?[index]
                                                                .textEditingController2,
                                                            index,
                                                          );
                                                        } else {
                                                          controller.onChaged(
                                                            products
                                                                ?.data?[index]
                                                                .textEditingController1,
                                                            index,
                                                          );
                                                          controller.onChaged(
                                                            products
                                                                ?.data?[index]
                                                                .textEditingController2,
                                                            index,
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                  itemCount:
                                                      productController.productsInventry.length,
                                                  crossAxisCount: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                      bottomNavigationMenu(context),
                                    ],
                                  ),
                                  Visibility(
                                    visible: controller.toggleOutlet,
                                    child: _outlets(controller),
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
      ),
    );
  }

  Widget _outlets(HomeController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 6.r, right: 6.r, top: 0.r),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.padding6,
            vertical: Dimensions.padding6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.padding8),
                child: Text(
                  "Select the outlet to place an order",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: TypographyResources.openSans,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              for (int i = 0; i < controller.outlets.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.padding8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.outlets[i],
                        style: TextStyle(fontFamily: TypographyResources.openSans),
                      ),
                      Visibility(
                        visible: controller.selectedOutlet == i,
                        child: Image.asset(Images.rightTale),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
