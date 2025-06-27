import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/data/banner_data.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/reusable/carousel_banner_controller.dart';
import 'package:quickb2b_v3_6/reusable/network_image.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget customCarousel({required double width, required double height, required List<BannerList> images}) {
  print(" banner list :: ${images.length}");
  return GetBuilder<CarouselBannerController>(
    builder: (bannerController) {
      return CarouselSlider(
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            bannerController.onPagedChanged(index);
          },
          autoPlay: true,
          height: height,
          viewportFraction: 1.0,
          // autoPlayInterval: Duration(seconds: 5),
          autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
        ),
        items:
            images.map((banner) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: width,
                    height: height,
                    // padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        cachedImageNetwork(url: banner.image ?? "", height: height, width: width, fit: BoxFit.fill),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.only(left: Dimensions.padding16, right: Dimensions.padding16, bottom: Dimensions.padding16), child: HtmlWidget(banner.bannerText ?? "")),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.r),
                              child: AnimatedSmoothIndicator(
                                activeIndex: bannerController.activeIndex,
                                count: bannerList.length,
                                effect: WormEffect(dotHeight: 8, dotWidth: 8, dotColor: Colors.white, activeDotColor: Colors.black, radius: 0),
                                onDotClicked: (index) => bannerController.carouselController.animateToPage(index),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
      );
    },
  );
}
