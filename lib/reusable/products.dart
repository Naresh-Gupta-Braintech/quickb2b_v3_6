import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickb2b_v3_6/reusable/network_image.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget productWidget({required String url, required String text}) {
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

Widget productOfProductList({required String url,required String price, required String name}) {
  return Container(
    width: 160.r,
    padding: EdgeInsets.only(top: 3.r, bottom: 4.r, left: 4.r, right: 4.r),
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.r)), border: Border.all(width: .5, color: Colors.grey)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("2", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), Image.asset(Images.hyphenInsideCircle)]),
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

        Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text(price, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: Dimensions.font12))),
        SizedBox(height: Dimensions.padding10),

        Visibility(
          visible: true,
          replacement: _textField(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.black, blendMode: BlendMode.darken, size: 15.r),
              SizedBox(width: 2.r),
              _textField(),
              Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding4), child: Icon(CupertinoIcons.multiply, color: Colors.grey, size: 15.r)),
              _textField(),
              SizedBox(width: 2.r),
              Icon(Icons.add, color: Colors.transparent, blendMode: BlendMode.darken, size: 15.r),
            ],
          ),
        ),
        SizedBox(height: 5.r),
      ],
    ),
  );
}

Widget _textField() {
  return SizedBox(
    width: 43.r,
    child: TextFormField(
      cursorHeight: 10.r, // Optional: match it to text size
      style: TextStyle(fontSize: 10.r), // Ensure text and cursor match
      textAlignVertical: TextAlignVertical.center, // Vertically center text
      decoration: InputDecoration(
        hintText: "each",
        hintStyle: TextStyle(fontSize: 10.r),
        contentPadding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 8.r), // Balanced padding
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
