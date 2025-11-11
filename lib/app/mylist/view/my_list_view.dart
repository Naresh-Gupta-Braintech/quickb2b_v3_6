import 'dart:async';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_dataservice.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/cart/cart_dataservice.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_controller.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_data_service.dart';
import 'package:quickb2b_v3_6/app/product/product_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/data/response/my_list_model.dart';
import 'package:quickb2b_v3_6/network/data/response/outlet_data.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/loader.dart';
import 'package:quickb2b_v3_6/reusable/navigation/custom_text.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/reusable/products_component.dart';
import 'package:quickb2b_v3_6/utils/colors_resources.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _MyListState();
}

class _MyListState extends State<MyListView> {
  int topNavigationIndex = 0;
  int? selectedIndex;
  @override
  void initState() {
    super.initState();
    Get.find<MyListController>().getUserData(0);
  }

  @override
  void dispose() {
    super.dispose();
    unawaited(Get.find<MyListController>().updateUserInventoryMyList());
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
              var bannersList = mylistController.myList?.bannerLists ?? [];
              var productWithCategory = mylistController.myList?.dataWithCategory ?? [];
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
                                      headerWithSearch(hint: "Search all products", appName: mylistController.myList?.appName ?? ""),
                                      Visibility(
                                        visible: (mylistController.myList?.showAppBanner == 1 && bannersList.isNotEmpty) ? true : false,
                                        child: Padding(padding: EdgeInsets.only(top: 5.r), child: customCarousel(width: Get.width, height: 130.r, images: bannersList)),
                                      ),
                                      SizedBox(height: 6.r),
                                      _myListMenue(list: productWithCategory),
                                      SizedBox(height: 6.r),
                                      mylistController.myList?.showItemInGridView == 0
                                          ?
                                          //list view
                                          Expanded(
                                            child: SizedBox(
                                              height: Get.height,
                                              child: ReorderableListView.builder(
                                                physics: const ClampingScrollPhysics(),
                                                itemCount: (productWithCategory.isNotEmpty ? productWithCategory[topNavigationIndex].data?.length ?? 0 : 0),
                                                onReorder: (oldIndex, newIndex) {
                                                  if (productWithCategory.isEmpty) return;
                                                  final list = productWithCategory[topNavigationIndex].data;
                                                  if (list == null) return;
                                                  if (newIndex > oldIndex) newIndex -= 1;
                                                  final item = list.removeAt(oldIndex);
                                                  list.insert(newIndex, item);
                                                  mylistController.update();
                                                },
                                                itemBuilder: (context, index) {
                                                  String showImage = mylistController.myList?.showImage ?? "";
                                                  int length = productWithCategory.length;
                                                  DataWithCategory? product;
                                                  if (length > 0) {
                                                    product = productWithCategory[topNavigationIndex];
                                                  }
                                                  return Container(
                                                    key: ValueKey(index),
                                                    padding: EdgeInsets.symmetric(vertical: 4.r),
                                                    child: horizontalProduct(
                                                      product: product?.data?[index] ?? Product(),
                                                      icon: Images.hyphenInsideCircle,
                                                      onTapHyphen: () {
                                                        mylistController.removeFromMyList(mylistController.myList?.dataWithCategory?[topNavigationIndex].data?[index].itemCode ?? "");
                                                      },
                                                      onTap: () {},
                                                      onChanged: (value) {
                                                        String? productId = mylistController.myList?.dataWithCategory?[topNavigationIndex].data?[index].itemCode;
                                                        mylistController.onChangeMyList(topNavigationIndex, index);
                                                        // mylistController.onChagedMylistProduct(
                                                        //   mylistController
                                                        //       .dataWithCategory?[mylistController.topNavigationIndex]
                                                        //       .data?[index]
                                                        //       .textEditingController1,
                                                        //   index,
                                                        // );
                                                        // Get.find<MyListController>().onChagedMylistProduct(null, index);
                                                        // if (products?.data?[index].isMeasBox == 0) {
                                                        //   Get.find<MyListController>().onChagedMylistProduct(
                                                        //     mylistController
                                                        //         .dataWithCategory?[mylistController.topNavigationIndex]
                                                        //         .data?[index]
                                                        //         .textEditingController2,
                                                        //     index,
                                                        //   );
                                                        // } else {
                                                        //   Get.find<MyListController>().onChagedMylistProduct(
                                                        //     mylistController
                                                        //         .dataWithCategory?[mylistController.topNavigationIndex]
                                                        //         .data?[index]
                                                        //         .textEditingController1,
                                                        //     index,
                                                        //   );
                                                        //   Get.find<MyListController>().onChagedMylistProduct(
                                                        //     mylistController
                                                        //         .dataWithCategory?[mylistController.topNavigationIndex]
                                                        //         .data?[index]
                                                        //         .textEditingController2,
                                                        //     index,
                                                        //   );
                                                        // }
                                                      },
                                                      isShowImage: showImage.trim().isNotEmpty ? int.tryParse(showImage) ?? 0 : 0,
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
                                                  itemCount: productWithCategory.length,
                                                  crossAxisCount: 2,
                                                  physics: const ClampingScrollPhysics(),
                                                  builder: (context, index) {
                                                    String showImage = productController.productdata?.showImage ?? "";
                                                    var product = productWithCategory[topNavigationIndex];
                                                    return verticalProduct(
                                                      product: product.data?[index] ?? Product(),
                                                      context: context,
                                                      isShowImage: showImage.trim().isNotEmpty ? int.tryParse(showImage) ?? 0 : 0,
                                                      onChanged: (value) {
                                                        // if (products?.data?[index].isMeasBox == 0) {
                                                        //   controller.onChaged(products?.data?[index].textEditingController2, index);
                                                        // } else {
                                                        //   controller.onChaged(products?.data?[index].textEditingController1, index);
                                                        //   controller.onChaged(products?.data?[index].textEditingController2, index);
                                                        // }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      bottomNavigationMenu(context),
                                    ],
                                  ),
                                  Visibility(visible: controller.toggleOutlet, child: _outlets(controller, mylistController)),
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

  void _setSelectedTopNavigation(int index) {
    setState(() {
      topNavigationIndex = index;
    });
  }

  Widget _outlets(HomeController controller, MyListController mylistController) {
    OutletData? outletsData = Get.find<LocalStorage>().getOutlets();
    var selectedOutlet = Get.find<LocalStorage>().getSelectedOutlets();
    var length = outletsData?.data?.length ?? 0;
    print("selected Outlet ::${selectedOutlet?.name}");
    print("outletsData :: ${outletsData?.data?.length}");
    return Padding(
      padding: EdgeInsets.only(left: 4.r, right: 4.r, top: 85.r),
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
                    await mylistController.getUserItems(0);
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

  Widget _myListMenue({required List<DataWithCategory> list}) {
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
                      // controller.setSelectedTopNavigation(index);
                      _setSelectedTopNavigation(index);
                      Get.find<ProductController>().page = 0;
                    },
                    child: selectedMenueText(text: list[index].categoryTitle ?? "", isSelected: index == topNavigationIndex),
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
}
