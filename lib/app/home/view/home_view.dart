import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/loader.dart';
import 'package:quickb2b_v3_6/reusable/navigation/navigation.dart';
import 'package:quickb2b_v3_6/reusable/products.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/text_field.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeController>().gethomeItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        var bannersList = controller.homeItems?.data?.bannerLists ?? [];
        var categoriesList = controller.homeItems?.data?.allCategories ?? [];
        var allInventories = controller.homeItems?.data?.allInventories ?? [];
        var specialInventories = controller.homeItems?.data?.specialInventories ?? [];
        return Scaffold(
          bottomNavigationBar: bottomNavigationMenu(),
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child:
                controller.loading
                    ? customLoader()
                    : Padding(
                      padding: EdgeInsets.only(bottom: 0.r),
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: headers(appname: controller.homeItems?.appName ?? "00", showPrice: int.tryParse(controller.homeItems?.showPrice ?? "0") ?? 0)),
                          SizedBox(height: Dimensions.padding10),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.r),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                customSearchBar(textController: TextEditingController(), textAlignment: TextAlign.center),
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
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: (controller.homeItems?.showAppBanner == 1 && bannersList.isNotEmpty) ? true : false,
                                        child: Padding(padding: EdgeInsets.only(top: 5.r), child: customCarousel(width: Get.width, height: 130.r, images: controller.homeItems?.data?.bannerLists ?? [])),
                                      ),
                                      SizedBox(height: Dimensions.padding16),
                                      Visibility(
                                        visible: (controller.homeItems?.data?.categoryExists == 1 && categoriesList.isNotEmpty),
                                        child: Column(
                                          children: [
                                            Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: _customSubHeading(text: "Search by Categories", buttonText: "See All")),
                                            SizedBox(height: 8.r),
                                            SizedBox(
                                              height: 106.r,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: controller.homeItems?.data?.allCategories?.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: categoryWidget(url: controller.homeItems?.data?.allCategories?[index].thumbImage ?? "", text: controller.homeItems?.data?.allCategories?[index].name ?? ""));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 16.r),
                                      Visibility(
                                        visible: specialInventories.isNotEmpty,
                                        child: Column(
                                          children: [
                                            Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: _customSubHeading(text: controller.homeItems?.specialHeaderTitle ?? "", buttonText: "See All")),
                                            SizedBox(height: 8.r),
                                            Visibility(
                                              child: SizedBox(
                                                height: 235.r,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: controller.homeItems?.data?.allInventories?.length,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.r),
                                                      child: specialProducts(
                                                        controller2: controller.myListControllers[index][1] ?? TextEditingController(),
                                                        controller1: controller.myListControllers[index][0]!,
                                                        url: controller.homeItems?.data?.specialInventories?[index].image ?? "",
                                                        price: controller.homeItems?.data?.specialInventories?[index].itemPrice ?? "",
                                                        name: controller.homeItems?.data?.specialInventories?[index].itemName ?? "",
                                                        isMeasBox: 1,
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
                                      Visibility(
                                        visible: (controller.homeItems?.showMyProduct == 1 && allInventories.isNotEmpty),
                                        child: Column(
                                          children: [
                                            Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: _customSubHeading(text: "My Products List", buttonText: "See All")),
                                            SizedBox(height: 8.r),
                                            Visibility(
                                              child: SizedBox(
                                                height: 223.r,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: controller.homeItems?.data?.allInventories?.length,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.r),
                                                      child: verticalProduct(
                                                        onChanged: (value) {
                                                          if (controller.homeItems?.data?.allInventories?[index].isMeasBox == 0) {
                                                            controller.onChaged(controller.homeItems?.data?.allInventories?[index].controller1, index);
                                                          } else {
                                                            controller.onChaged(controller.homeItems?.data?.allInventories?[index].controller1, index);
                                                            controller.onChaged(controller.homeItems?.data?.allInventories?[index].controller2, index);
                                                          }
                                                        },
                                                        controller1: controller.homeItems?.data?.allInventories?[index].controller1 ?? TextEditingController(),
                                                        controller2: controller.homeItems?.data?.allInventories?[index].controller2 ?? TextEditingController(),
                                                        isShowImage: int.tryParse(controller.homeItems?.showImage ?? "0") ?? 0,
                                                        hint: controller.homeItems?.data?.allInventories?[index].uom ?? "",
                                                        url: controller.homeItems?.data?.allInventories?[index].image ?? "",
                                                        price: controller.homeItems?.data?.allInventories?[index].itemPrice ?? "",
                                                        name: controller.homeItems?.data?.allInventories?[index].itemName ?? "",
                                                        isMeasBox: controller.homeItems?.data?.allInventories?[index].isMeasBox ?? 0,
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
                                      Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: _customSubHeading(text: "Featured", buttonText: "")),
                                      SizedBox(height: Dimensions.padding10),
                                      Image.asset(Images.featuredGradient),
                                      SizedBox(height: Dimensions.padding10),
                                      Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: HtmlWidget(controller.homeItems?.data?.featuredItemImage?.content ?? "")),
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
          ),
        );
      },
    );
  }

  Widget _customSubHeading({required String text, required String buttonText}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontFamily: TypographyResources.openSans)), GestureDetector(onTap: () {}, child: Text(buttonText, style: TextStyle(color: Colors.grey, fontSize: 10.r)))]);
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
