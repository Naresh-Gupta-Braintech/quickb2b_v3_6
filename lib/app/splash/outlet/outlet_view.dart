import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class OutletView extends StatefulWidget {
  const OutletView({super.key});

  @override
  State<OutletView> createState() => _OutletViewState();
}

class _OutletViewState extends State<OutletView> {
  @override
  void initState() {
    super.initState();
    print("outlet view");
    Get.find<HomeController>().getOutletinfo();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        int length = controller.outlet?.data?.length ?? 0;
        print("length :: $length && ${(23.r * length)}");
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Image.asset(Images.login, fit: BoxFit.cover, width: Get.width, height: Get.height),
              Container(
                color: Colors.grey[300],
                width: Get.width,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        Get.find<SplashController>().sharedPreferences.getString(Keys.appName) ?? "",
                        style: TextStyle(fontSize: Dimensions.font14, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Select the outlet to place an order",
                        style: TextStyle(fontSize: Dimensions.font12, fontFamily: TypographyResources.openSans, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.r),
                      SizedBox(
                        height: (40.r * length),
                        child: ListView.builder(
                          itemCount: length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                controller.handleOnTapOutlet(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
                                decoration:
                                    controller.selectedOutled == index ? BoxDecoration(color: Colors.grey) : BoxDecoration(color: Colors.grey[300]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.outlet?.data?[index].name ?? "",
                                      style: TextStyle(
                                        fontSize: Dimensions.font15,
                                        fontFamily: TypographyResources.openSans,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(Icons.arrow_back),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
