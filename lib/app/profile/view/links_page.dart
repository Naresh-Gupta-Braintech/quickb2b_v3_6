import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_controller.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class LinksPage extends StatefulWidget {
  const LinksPage({super.key});

  @override
  State<LinksPage> createState() => _LinksPageState();
}

class _LinksPageState extends State<LinksPage> {
  @override
  void initState() {
    super.initState();
    Get.find<ProfileDashboardController>().getLinkDeatils();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileDashboardController>(
      builder: (controller) {
        var websites = controller.links?.data?.websites ?? [];
        var pdf = controller.links?.data?.pdf ?? [];
        var representative = controller.links?.data?.representatives;

        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(Images.linkBackground, fit: BoxFit.cover),
              Column(
                children: [
                  SizedBox(height: Dimensions.viewHeight60),
                  _subHeading(text: "Our Website".toUpperCase()),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: websites.length,
                    itemBuilder: (context, index) {
                      return Padding(padding: EdgeInsets.symmetric(vertical: 16.r), child: _customtext(text: websites[index].link ?? ""));
                    },
                  ),
                  _subHeading(text: "Request Account Statement".toUpperCase()),
                  SizedBox(height: Dimensions.viewHeight16),

                  _customtext(text: controller.links?.data?.statementEmail ?? ""),
                  SizedBox(height: Dimensions.viewHeight16),

                  _subHeading(text: "Contact My Account Manager".toUpperCase()),
                  SizedBox(height: Dimensions.viewHeight16),

                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      GlobalConstants.sendEmail(representative?.email ?? "");
                    },
                    child: _subHeading(text: "Email", color: Colors.grey),
                  ),
                  SizedBox(height: Dimensions.viewHeight16),

                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      GlobalConstants.makePhoneCall(representative?.phone ?? "");
                    },
                    child: _subHeading(text: "Call", color: Colors.grey),
                  ),
                  SizedBox(height: Dimensions.viewHeight16),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: pdf.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _subHeading(text: pdf[index].title ?? ""),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.r),
                            child: _customImageWidget(
                              onTap: () {
                                GlobalConstants.launchInBrowser(pdf[index].link ?? "");
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _subHeading({required String text, Color? color}) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(color: color ?? Colors.black),
      child: Padding(padding: EdgeInsets.symmetric(vertical: 8.r), child: Text(textAlign: TextAlign.center, text.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: Dimensions.font14, fontFamily: TypographyResources.openSans))),
    );
  }

  Widget _customtext({required String text}) {
    return Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: TypographyResources.openSans, fontSize: Dimensions.font14, fontWeight: FontWeight.w700));
  }

  Widget _customImageWidget({required VoidCallback onTap}) {
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: Image.asset(Images.pdf));
  }
}
