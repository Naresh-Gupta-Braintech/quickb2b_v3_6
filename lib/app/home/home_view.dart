import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/data/banner_data.dart';
import 'package:quickb2b_v3_6/reusable/carousel.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/reusable/network_image.dart';
import 'package:quickb2b_v3_6/reusable/products.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: headers()),
            SizedBox(height: Dimensions.padding10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [customSearchBar(textController: TextEditingController()), Container(padding: EdgeInsets.all(7.r), decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Colors.black, width: 1)), child: Image.asset(Images.outlet, height: 19.r))],
            ),
            SizedBox(height: Dimensions.padding10),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    customCarousel(width: Get.width, height: 130.r, images: bannerList),
                    SizedBox(height: Dimensions.padding16),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: _customSubHeading(text: "Search by Categories", buttonText: "See All")),
                    SizedBox(height: 8.r),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: productWidget(url: "https://develop.quickb2b.com/img/default/category/no_img_available_thumb.png", text: "Fruit")),
                    SizedBox(height: 16.r),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: _customSubHeading(text: "My Products List", buttonText: "See All")),
                    SizedBox(height: 8.r),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: productOfProductList(url: "https://develop.quickb2b.com/files/inventory/QuickB2B_Develop/1658124745no-image-available.png")),
                    SizedBox(height: Dimensions.padding16),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.r), child: _customSubHeading(text: "Featured", buttonText: "")),
                    SizedBox(height: Dimensions.padding10),
                    Image.asset(Images.featuredGradient),
                    SizedBox(height: Dimensions.padding10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.r),
                      child: HtmlWidget(
                        """<p style="text-align:center;"><span style="font-family:Arial;font-size:16px;">Mangoes \$3.00 each</span></p><p style="text-align:center;"><br><span style="font-family:Arial;font-size:18px;"><img src="https:\/\/develop.quickb2b.com\/files\/lfm\/photos\/quickb2b-develop\/64c068c0e5e48.png" alt="" width="250" height="167"></span></p><hr><p style="text-align:center;"><span style="font-family:Arial;font-size:16px;">Watermelon Whole&nbsp;\$2.00 per kg</span></p><p style="text-align:center;"><img src="https:\/\/develop.quickb2b.com\/files\/lfm\/photos\/quickb2b-develop\/612ec63eee06d.jpg" alt="" width="200" height="133"></p><hr><p style="text-align:center;"><span style="font-family:Arial;font-size:16px;">Limes&nbsp;\$1.40 each</span><br><br><span style="font-family:Arial;font-size:16px;"><img src="https:\/\/develop.quickb2b.com\/files\/lfm\/photos\/quickb2b-develop\/64c068c13331e.png" alt="" width="200" height="133"></span></p><hr> """,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customSubHeading({required String text, required String buttonText}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontFamily: TypographyResources.openSans)), GestureDetector(onTap: () {}, child: Text(buttonText, style: TextStyle(color: Colors.grey, fontSize: 10.r)))]);
  }

  Widget _customText({required String text, required double fontSize}) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: fontSize));
  }
}
