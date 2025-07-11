import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/product/product_controller.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/loader.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/reusable/products.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/text_field.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ScrollController _productScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _productScrollController.addListener(() {
      if (_productScrollController.position.atEdge) {
        if (_productScrollController.position.pixels == 0) {
        } else {
          Get.find<ProductController>().page += 1;
          Get.find<ProductController>().searchProductByCategoryId(Get.find<ProductController>().previousCategory);
        }
      }
    });
    Get.find<ProductController>().getAllCategories();
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    _productScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    productController.loading
                        ? customLoader()
                        : Column(
                          children: [
                            Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: headers(appname: controller.homeItems?.appName ?? "00", showPrice: int.tryParse(controller.homeItems?.showPrice ?? "0") ?? 0)),
                            SizedBox(height: Dimensions.padding10),
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  customSearchBar(textController: TextEditingController(), textAlignment: TextAlign.start),
                                  InkWell(
                                    onTap: () => {controller.setToogleOutlet()},
                                    child: Container(padding: EdgeInsets.all(7.r), decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Colors.black, width: 1)), child: Image.asset(Images.outlet, height: 19.r)),
                                  ),
                                ],
                              ),
                            ),
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
                                        categoryListMenu(list: productController.categories?.categories ?? []),
                                        SizedBox(height: 6.r),
                                        //list view
                                        productController.productdata?.showItemInGridView == 1
                                            ? SizedBox(
                                              height: Get.height,
                                              width: Get.width,
                                              child: ListView.builder(
                                                physics: const ClampingScrollPhysics(),
                                                controller: _productScrollController,
                                                itemCount: productController.productsInventry.length,
                                                itemBuilder: (context, index) {
                                                  String showImage = productController?.productdata?.showImage ?? "";
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
                                            )
                                            :
                                            //Grid view
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 4.r),
                                              child: SizedBox(
                                                height: Get.height,
                                                child: DynamicHeightGridView(
                                                  controller: _productScrollController,
                                                  builder: (context, index) {
                                                    String showImage = productController?.productdata?.showImage ?? "";

                                                    return verticalProduct(
                                                      url: productController.productsInventry[index]?.image ?? "",
                                                      price: productController.productsInventry[index]?.itemPrice ?? "",
                                                      name: productController.productsInventry[index]?.itemName ?? "",
                                                      isMeasBox: productController.productsInventry[index]?.isMeasBox ?? 0,
                                                      hint: productController.productsInventry[index]?.uom ?? "",
                                                      isShowImage: showImage.trim().isNotEmpty ? int.tryParse(showImage) ?? 0 : 0,
                                                      controller1: TextEditingController(),
                                                      controller2: TextEditingController(),
                                                    );
                                                  },
                                                  itemCount: productController.productsInventry.length,
                                                  crossAxisCount: 2,
                                                ),
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
