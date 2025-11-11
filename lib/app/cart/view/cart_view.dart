import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/reusable/buttons.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/reusable/network_image.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
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
    Get.find<CartController>().getCartDataLocally();
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
      child: GetBuilder<CartController>(
        builder: (cartController) {
          return GetBuilder<HomeController>(
            builder: (controller) {
              var bannersList = cartController.cartData?.data?.bannerLists ?? [];
              var orders = cartController.cartData?.data?.allInventories ?? [];

              return Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: bottomNavigationMenu(context),
                body: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.r),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.padding10),
                        headerWithSearch(appName: cartController.cartData?.appName ?? "", isSearchBarFull: true, showOutlet: false),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Visibility(
                                  visible: (cartController.cartData?.showAppBanner == 1 && bannersList.isNotEmpty) ? true : false,
                                  child: Padding(padding: EdgeInsets.only(top: 5.r), child: customCarousel(width: Get.width, height: 130.r, images: bannersList)),
                                ),
                                SizedBox(height: 8.r),
                                Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(child: Row(children: [Visibility(visible: false, child: Icon(Icons.ac_unit)), Text("Item")])),
                                      Flexible(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Qty"), Text("Measure"), Text("Price")])),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cartController.cartData?.data?.allInventories?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                cartController.isEdit
                                                    ? GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        cartController.removedItem(index);
                                                      },
                                                      child: Image.asset(Images.redCross, height: 30.r),
                                                    )
                                                    : cachedImageNetwork(url: orders[index].image ?? "", height: 30.r),
                                                Flexible(child: Text(orders[index].itemName ?? "", maxLines: 1)),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // if (orders[index].isMeasBox == 0)
                                                cartController.isEdit
                                                    ? customTextFieldWithWidthConstraint(
                                                      controller: cartController.cartData?.data?.allInventories?[index].controller2 ?? TextEditingController(),
                                                      hintText: cartController.cartData?.data?.allInventories?[index].uom ?? "",
                                                      borderColor: Colors.grey,
                                                    )
                                                    : Text(orders[index].quantity ?? ""),

                                                // if (orders[index].isMeasBox == 1)
                                                cartController.isEdit && orders[index].isMeasBox == 1
                                                    ? customTextFieldWithWidthConstraint(
                                                      controller: cartController.cartData?.data?.allInventories?[index].controller1 ?? TextEditingController(),
                                                      hintText: cartController.cartData?.data?.allInventories?[index].uom ?? "",
                                                      borderColor: Colors.grey,
                                                    )
                                                    : orders[index].isMeasBox == 1
                                                    ? Text(orders[index].measureQty ?? "-")
                                                    : Text("-"),
                                                Text("\$ ${orders[index].itemPrice}"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 10.r),
                                Divider(color: Colors.grey, thickness: 0.5),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.r),
                                  child: customTextFieldWithSuffix(textFieldLabel: "Delivery:", controller: TextEditingController(), icon: Icons.calendar_month),
                                ),
                                SizedBox(height: 8.r),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.r),
                                  child: customTextField2(height: 40.r, controller: TextEditingController(), textFieldLabel: "PO Number:", borderColor: Colors.grey, borderWidth: 0.5.r),
                                ),
                                SizedBox(height: 8.r),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.r),
                                  child: customTextFieldWithMaxLines(
                                    controller: TextEditingController(),
                                    textFieldLabel: "Comment:",
                                    borderColor: Colors.grey,
                                    borderWidth: 0.5.r,
                                    maxLine: 5,
                                  ),
                                ),
                                SizedBox(height: 16.r),
                                cartController.isEdit
                                    ? customButton2(
                                      textLabel: "Save Changes",
                                      width: 140.r,
                                      color: Colors.black,
                                      height: 40,
                                      fontSize: Dimensions.font14,

                                      onPressed: () {
                                        cartController.saveEditable();
                                      },
                                    )
                                    : customButton2(
                                      textLabel: "Edit",
                                      width: 140.r,
                                      color: Colors.grey,
                                      height: 40,
                                      fontSize: Dimensions.font14,
                                      onPressed: () {
                                        cartController.makeEditable();
                                      },
                                    ),
                                SizedBox(height: 8.r),
                                customButton2(textLabel: "Submit Order", width: 140.r, color: Colors.black, height: 40, fontSize: Dimensions.font14, onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.r),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
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
