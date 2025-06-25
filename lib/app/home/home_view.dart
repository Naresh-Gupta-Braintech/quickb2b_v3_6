import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/data/banner_data.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/text_field.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeIndex = 0;
  final int itemCount = 3;
  CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          headers(),
          SizedBox(height: Dimensions.padding10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customSearchBar(textController: TextEditingController()),
              Container(padding: EdgeInsets.all(Dimensions.padding8), decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Colors.black, width: 1)), child: Image.asset(Images.outlet, height: 20)),
            ],
          ),
          SizedBox(height: Dimensions.padding10),
          customCarousel(width: Get.width, height: 130.r, images: bannerList),
          SizedBox(height: Dimensions.padding10),
        ],
      ),
    );
  }
}
