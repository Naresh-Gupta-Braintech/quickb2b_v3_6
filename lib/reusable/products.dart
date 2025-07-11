import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/reusable/network_image.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget categoryWidget({required String url, required String text}) {
  return Container(
    padding: EdgeInsets.only(top: 3.r, bottom: 4.r, left: 4.r, right: 4.r),
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.r)), border: Border.all(width: .5, color: Colors.grey)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.r,
          child: AspectRatio(
            aspectRatio: 4 / 3, // Force 4:3 box
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: cachedImageNetwork(
                url: url,
                fit: BoxFit.cover, // Crop and fill inside 4:3 box
              ),
            ),
          ),
        ),
        SizedBox(height: 5.r),
        Text(text, style: TextStyle(fontFamily: TypographyResources.openSans, fontSize: 10.r, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
      ],
    ),
  );
}

Widget verticalProduct({Function(String value)? onChanged, required String url, required String price, required String name, required int isMeasBox, required String hint, required int isShowImage, required TextEditingController controller1, required TextEditingController controller2}) {
  return Container(
    width: 160.r,
    height: 230.r,
    padding: EdgeInsets.only(top: 3.r, bottom: 4.r, left: 4.r, right: 4.r),
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.r)), border: Border.all(width: .5, color: Colors.grey)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Visibility(visible: isMeasBox == 1, child: Text("2", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))), Image.asset(Images.hyphenInsideCircle)]),
        SizedBox(height: Dimensions.padding10),
        Visibility(
          visible: url.isNotEmpty || isShowImage == 1,
          child: SizedBox(
            width: 100.r,
            child: AspectRatio(
              aspectRatio: 4 / 3, // Force 4:3 box
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: cachedImageNetwork(
                  url: url,
                  fit: BoxFit.cover, // Crop and fill inside 4:3 box
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.padding10),
        Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text(name, maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: 12.r))),

        // Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text("Alfalfa Punnet 125g - order by Each", maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: 12.r))),
        SizedBox(height: Dimensions.padding6),

        Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text(price, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: Dimensions.font12))),
        SizedBox(height: Dimensions.padding10),

        Visibility(
          visible: true,
          replacement: _textField(hint: "", controller: controller2, textFieldWidth: 43.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: isMeasBox == 1,
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.black, blendMode: BlendMode.darken, size: 15.r),
                    SizedBox(width: 2.r),
                    _textField(hint: "Qty", controller: controller1, onChanged: onChanged, textFieldWidth: 55.r),
                    Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding4), child: Icon(CupertinoIcons.multiply, color: Colors.grey, size: 15.r)),
                  ],
                ),
              ),
              _textField(hint: hint, controller: controller2, textFieldWidth: 43.r),
              Visibility(visible: isMeasBox == 1, child: Row(children: [SizedBox(width: 2.r), Icon(Icons.add, color: Colors.transparent, blendMode: BlendMode.darken, size: 15.r)])),
            ],
          ),
        ),
        SizedBox(height: 5.r),
      ],
    ),
  );
}

Widget _textField({required String hint, required TextEditingController controller, Function(String value)? onChanged, required double textFieldWidth}) {
  return SizedBox(
    width: textFieldWidth,
    child: TextFormField(
      onChanged: onChanged,
      controller: controller,
      cursorHeight: 10.r, // Optional: match it to text size
      style: TextStyle(fontSize: 10.r), // Ensure text and cursor match
      textAlignVertical: TextAlignVertical.center, // Vertically center text
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 10.r),
        contentPadding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 0.r), // Balanced padding
        isDense: true, // Reduces height further
        constraints: BoxConstraints(maxHeight: 26.r), // Control total height
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: .8, color: Colors.grey)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: .8, color: Colors.grey)),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    ),
  );
}

const str = "\$";

Widget specialProducts({required TextEditingController controller1, required TextEditingController controller2, required String url, required String price, required String name, required int isMeasBox, required String hint}) {
  return Container(
    width: 160.r,
    padding: EdgeInsets.only(top: 3.r, bottom: 4.r, left: 4.r, right: 4.r),
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.r)), border: Border.all(width: .5, color: Colors.grey)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("2", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), Image.asset(Images.addRounded)]),
        SizedBox(height: Dimensions.padding10),
        Visibility(
          visible: url.isNotEmpty,
          child: SizedBox(
            width: 100.r,
            child: AspectRatio(
              aspectRatio: 4 / 3, // Force 4:3 box
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: cachedImageNetwork(
                  url: url,
                  fit: BoxFit.cover, // Crop and fill inside 4:3 box
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.padding10),
        Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text(name, maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: 12.r))),

        // Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text("Alfalfa Punnet 125g - order by Each", maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: 12.r))),
        SizedBox(height: Dimensions.padding6),

        Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text(price, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: Dimensions.font12))),
        SizedBox(height: Dimensions.padding10),

        Visibility(
          visible: true,
          replacement: _textField(hint: "", controller: controller2, textFieldWidth: 43.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: isMeasBox == 1,
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.black, blendMode: BlendMode.darken, size: 15.r),
                    SizedBox(width: 2.r),
                    _textField(hint: "Qty", controller: controller1, textFieldWidth: 43.r),
                    Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding4), child: Icon(CupertinoIcons.multiply, color: Colors.grey, size: 15.r)),
                  ],
                ),
              ),
              _textField(hint: hint, controller: controller2, textFieldWidth: 43.r),
              Visibility(visible: isMeasBox == 1, child: Row(children: [SizedBox(width: 2.r), Icon(Icons.add, color: Colors.transparent, blendMode: BlendMode.darken, size: 15.r)])),
            ],
          ),
        ),
        SizedBox(height: 2.r),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [Image.asset(Images.starFill)]),
      ],
    ),
  );
}

Widget horizontalProduct({
  Function(String value)? onChanged,
  required String url,
  required String price,
  required String name,
  required int isMeasBox,
  required String hint,
  required int isShowImage,
  required TextEditingController controller1,
  required TextEditingController controller2,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.r),

    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.r)), border: Border.all(width: .5, color: Colors.grey)),
        padding: EdgeInsets.only(top: 5.r, bottom: 0.r, left: 25.r, right: 5.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100.r,
              child: AspectRatio(
                aspectRatio: 4 / 3, // Force 4:3 box
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: cachedImageNetwork(
                    url: url,
                    fit: BoxFit.cover, // Crop and fill inside 4:3 box
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text("\$$price" ?? "", style: TextStyle(fontWeight: FontWeight.w600, fontFamily: TypographyResources.openSans, fontSize: 11.r)),
                    SizedBox(width: Dimensions.padding8),

                    Visibility(
                      visible: true,
                      replacement: _textField(hint: "", controller: controller2, textFieldWidth: 55.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: isMeasBox == 1,
                            child: Row(children: [SizedBox(width: 2.r), _textField(hint: "Qty", controller: controller1, textFieldWidth: 55.r), Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding4), child: Icon(CupertinoIcons.multiply, color: Colors.grey, size: 15.r))]),
                          ),
                          _textField(hint: hint, controller: controller2, textFieldWidth: 55.r),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.padding8),
                SizedBox(width: Get.width * 0.6, child: Text(name, maxLines: 2, textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.w600, fontFamily: TypographyResources.openSans, fontSize: 10.r))),

                SizedBox(height: Dimensions.padding8),
                Row(children: [Visibility(visible: isMeasBox == 1, child: Icon(Icons.add, color: Colors.black, size: 20.r)), Image.asset(Images.radioAdd, height: 30.r)]),
                SizedBox(height: Dimensions.padding4),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
