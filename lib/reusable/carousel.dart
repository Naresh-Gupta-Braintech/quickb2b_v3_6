import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/reusable/carousel_banner_controller.dart';
import 'package:quickb2b_v3_6/reusable/network_image.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget customCarousel({required double width, required double height, required List<BannerList> images}) {
  return GetBuilder<CarouselBannerController>(
    builder: (bannerController) {
      return Stack(
        children: [
          // Carousel (sliding part)
          CarouselSlider(
            carouselController: bannerController.carouselController,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                bannerController.onPagedChanged(index);
              },
              autoPlay: true,
              height: height,
              viewportFraction: 1.0,
              autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
            ),
            items:
                images.map((banner) {
                  return Builder(
                    builder: (context) {
                      return Container(
                        width: width,
                        height: height,
                        child: cachedImageNetwork(url: banner.image ?? "", height: height, width: width, fit: BoxFit.fill),
                      );
                    },
                  );
                }).toList(),
          ),

          // Fixed overlay (stays in place)
          Positioned(
            bottom: 2.r,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.padding16),
                  child: HtmlWidget(images[bannerController.activeIndex].bannerText ?? ""),
                ),
                SizedBox(height: 10),
                AnimatedSmoothIndicator(
                  activeIndex: bannerController.activeIndex,
                  count: images.length,
                  effect: WormEffect(dotHeight: 6, dotWidth: 6, dotColor: Colors.white, activeDotColor: Colors.black, radius: 0),
                  onDotClicked: (index) {
                    bannerController.carouselController.animateToPage(index);
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      );
    },
  );
}
