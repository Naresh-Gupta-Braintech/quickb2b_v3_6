import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/reusable/buttons.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/reusable/network_image.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/text_field.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    Get.find<CartController>().getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        return GetBuilder<HomeController>(
          builder: (controller) {
            var bannersList = controller.homeItems?.data?.bannerLists ?? [];
            var orders = cartController.cartData?.data?.allInventories ?? [];
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: bottomNavigationMenu(),
              body: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0.r),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.padding10),
                      headerWithSearch(appName: controller.homeItems?.appName ?? "", isSearchBarFull: true, showOutlet: false),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              Visibility(
                                visible: (controller.homeItems?.showAppBanner == 1 && bannersList.isNotEmpty) ? true : false,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.r),
                                  child: customCarousel(width: Get.width, height: 130.r, images: controller.homeItems?.data?.bannerLists ?? []),
                                ),
                              ),
                              SizedBox(height: 8.r),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.r),
                                child: Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FixedColumnWidth((Get.width) * 0.45),
                                    1: FixedColumnWidth((Get.width) * 0.15),
                                    2: FixedColumnWidth((Get.width) * 0.25),
                                    3: FixedColumnWidth((Get.width) * 0.15),
                                  },
                                  border: const TableBorder.symmetric(inside: BorderSide.none, outside: BorderSide.none),
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey, width: 0.5),
                                        borderRadius: BorderRadius.all(Radius.circular(4.r)),
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 4.r),
                                          child: Text(
                                            "Item".toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: TypographyResources.openSans,
                                              fontSize: Dimensions.font14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "QTY",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: TypographyResources.openSans,
                                            fontSize: Dimensions.font14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 4.r),
                                          child: Text(
                                            "Measure".toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: TypographyResources.openSans,
                                              fontSize: Dimensions.font14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 4.r),
                                          child: Text(
                                            "price".toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: TypographyResources.openSans,
                                              fontSize: Dimensions.font14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    for (var order in orders)
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.r, vertical: 16.r),
                                            child: SizedBox(
                                              width: Get.width * 0.5,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  cachedImageNetwork(url: order.image ?? "", height: 30),
                                                  Flexible(
                                                    child: Text(
                                                      order.itemName ?? "",
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.clip,
                                                      maxLines: 1,
                                                      style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.r),
                                            child: Text(
                                              order.quantity ?? "",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font14),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.r),

                                            child: Text(
                                              order.measureQty ?? "",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font14),
                                            ),
                                          ),
                                          Text(
                                            " ${cartController.cartData?.currencySymbol ?? ""}${order.itemPrice}" ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: Dimensions.font14),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.r),
                              Divider(color: Colors.grey, thickness: 0.5),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.r),
                                child: customTextFieldWithSuffix(
                                  textFieldLabel: "Delivery:",
                                  controller: TextEditingController(),
                                  icon: Icons.calendar_month,
                                ),
                              ),
                              SizedBox(height: 8.r),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.r),
                                child: customTextField2(
                                  controller: TextEditingController(),
                                  textFieldLabel: "PO Number",
                                  borderColor: Colors.grey,
                                  borderWidth: 0.5.r,
                                  // maxLine: 1,
                                ),
                              ),
                              SizedBox(height: 8.r),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.r),
                                child: customTextField2(
                                  controller: TextEditingController(),
                                  textFieldLabel: "",
                                  borderColor: Colors.grey,
                                  borderWidth: 0.5.r,
                                  maxLine: 5,
                                  height: 250.r,
                                ),
                              ),

                              customButton2(textLabel: "Edit order", width: 120.r, color: Colors.black54, onPressed: () {}),
                            ],
                          ),
                        ),
                      ),
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
}
