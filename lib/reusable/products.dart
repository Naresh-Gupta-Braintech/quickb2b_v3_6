import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:quickb2b_v3_6/reusable/network_image.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

Widget categoryWidget({required String url, required String text}) {
  return Container(
    padding: EdgeInsets.only(top: 3.r, bottom: 4.r, left: 4.r, right: 4.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4.r)),
      border: Border.all(width: .5, color: Colors.grey),
    ),
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
        Text(
          text,
          style: TextStyle(
            fontFamily: TypographyResources.openSans,
            fontSize: 10.r,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget verticalProduct({
  Function(String value)? onChanged,
  required String url,
  required String price,
  required String name,
  required int isMeasBox,
  required String hint,
  required int isShowImage,
  required TextEditingController controller1,
  required TextEditingController controller2,
  required String originQty,
  required String measureQty,
}) {
  double orgQty = double.tryParse(originQty) ?? 0;
  if (orgQty == 0) {
    originQty = "";
  }
  if (isMeasBox == 0) {
    controller2.text = originQty;
  } else {
    controller1.text = measureQty;
    controller2.text = originQty;
  }
  return Container(
    width: 165.r,
    height: 230.r,
    padding: EdgeInsets.only(top: 3.r, bottom: 4.r, left: 4.r, right: 4.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4.r)),
      border: Border.all(width: .5, color: Colors.grey),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: isMeasBox == 1,
              child: Text("2", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            Image.asset(Images.hyphenInsideCircle),
          ],
        ),
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12),
          child: Text(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: TypographyResources.openSans,
              fontSize: 12.r,
            ),
          ),
        ),

        // Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text("Alfalfa Punnet 125g - order by Each", maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: 12.r))),
        SizedBox(height: Dimensions.padding6),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12),
          child: Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: TypographyResources.openSans,
              fontSize: Dimensions.font12,
            ),
          ),
        ),
        SizedBox(height: Dimensions.padding10),

        Visibility(
          visible: true,
          replacement: _textField(hint: "", controller: controller1, textFieldWidth: 43.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: isMeasBox == 1,
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.black, size: 15.r),
                    SizedBox(width: 2.r),
                    _textField(
                      hint: "Qty",
                      controller: controller1,
                      onChanged: onChanged,
                      textFieldWidth: 55.r,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.padding4),
                      child: Icon(CupertinoIcons.multiply, color: Colors.grey, size: 15.r),
                    ),
                  ],
                ),
              ),
              _textField(
                hint: hint,
                controller: controller2,
                textFieldWidth: 43.r,
                onChanged: onChanged,
              ),
              Visibility(
                visible: isMeasBox == 1,
                child: Row(
                  children: [
                    SizedBox(width: 2.r),
                    Icon(Icons.add, color: Colors.transparent, size: 15.r),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.r),
      ],
    ),
  );
}

Widget _textField({
  required String hint,
  required TextEditingController controller,
  Function(String value)? onChanged,
  required double textFieldWidth,
}) {
  return SizedBox(
    width: textFieldWidth,
    child: TextFormField(
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      controller: controller,
      cursorHeight: 10.r,
      style: TextStyle(fontSize: 10.r),
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 10.r),
        contentPadding: EdgeInsets.symmetric(vertical: 0.r, horizontal: 0.r),
        constraints: BoxConstraints(maxHeight: 25.r),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: .8, color: Colors.grey)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: .8, color: Colors.grey)),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    ),
  );
}

Widget _cupertinoTextField({
  required String hint,
  required TextEditingController controller,
  Function(String value)? onChanged,
  required double textFieldWidth,
}) {
  final FocusNode _focusNode = FocusNode();
  return KeyboardActions(
    config: KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      actions: [
        KeyboardActionsItem(
          focusNode: _focusNode,
          toolbarButtons: [
            (node) => TextButton(onPressed: () => node.unfocus(), child: Text("Done")),
          ],
        ),
      ],
    ),
    child: SizedBox(
      width: textFieldWidth,
      child: TextFormField(
        textInputAction: TextInputAction.done,
        onChanged: onChanged,
        controller: controller,
        cursorHeight: 10.r,
        style: TextStyle(fontSize: 10.r),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 10.r),
          contentPadding: EdgeInsets.symmetric(vertical: 0.r, horizontal: 0.r),
          constraints: BoxConstraints(maxHeight: 25.r),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: .8, color: Colors.grey)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: .8, color: Colors.grey)),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    ),
  );
}

const str = "\$";

Widget specialProducts({
  required TextEditingController controller1,
  required TextEditingController controller2,
  required String url,
  required String price,
  required String name,
  required int isMeasBox,
  required String hint,
}) {
  return Container(
    width: 160.r,
    padding: EdgeInsets.only(top: 3.r, bottom: 4.r, left: 4.r, right: 4.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4.r)),
      border: Border.all(width: .5, color: Colors.grey),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("2", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            Image.asset(Images.addRounded),
          ],
        ),
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12),
          child: Text(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: TypographyResources.openSans,
              fontSize: 12.r,
            ),
          ),
        ),

        // Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12), child: Text("Alfalfa Punnet 125g - order by Each", maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontFamily: TypographyResources.openSans, fontSize: 12.r))),
        SizedBox(height: Dimensions.padding6),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12),
          child: Text(
            price,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w800,
              fontFamily: TypographyResources.openSans,
              fontSize: Dimensions.font12,
            ),
          ),
        ),
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
                    Icon(Icons.add, color: Colors.black, size: 15.r),
                    SizedBox(width: 2.r),
                    _textField(hint: "Qty", controller: controller1, textFieldWidth: 43.r),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.padding4),
                      child: Icon(CupertinoIcons.multiply, color: Colors.grey, size: 15.r),
                    ),
                  ],
                ),
              ),
              _textField(hint: hint, controller: controller2, textFieldWidth: 43.r),
              Visibility(
                visible: isMeasBox == 1,
                child: Row(
                  children: [
                    SizedBox(width: 2.r),
                    Icon(Icons.add, color: Colors.transparent, size: 15.r),
                  ],
                ),
              ),
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
  required String originQty,
  required String measureQty,
  required VoidCallback onTapIcon,
  required String icon,
  int inMyList = 0,
}) {
  double orgQty = double.tryParse(originQty) ?? 0;
  if (orgQty == 0) {
    originQty = "";
  }
  if (isMeasBox == 0) {
    controller2.text = originQty;
  } else {
    controller1.text = measureQty;
    controller2.text = originQty;
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.r),

    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
          border: Border.all(width: .5, color: Colors.grey),
        ),
        padding: EdgeInsets.only(top: 5.r, bottom: 0.r, left: 25.r, right: 5.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100.r,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: cachedImageNetwork(url: url, fit: BoxFit.cover),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "\$$price",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: TypographyResources.openSans,
                        fontSize: 11.r,
                      ),
                    ),
                    SizedBox(width: Dimensions.padding8),

                    Visibility(
                      visible: true,
                      replacement: _textField(
                        hint: "",
                        controller: controller2,
                        textFieldWidth: 55.r,
                        onChanged: onChanged,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: isMeasBox == 1,
                            child: Row(
                              children: [
                                SizedBox(width: 2.r),
                                _textField(
                                  hint: "Qty",
                                  controller: controller1,
                                  textFieldWidth: 55.r,
                                  onChanged: onChanged,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.padding4),
                                  child: Icon(
                                    CupertinoIcons.multiply,
                                    color: Colors.grey,
                                    size: 15.r,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _textField(
                            hint: hint,
                            controller: controller2,
                            textFieldWidth: 55.r,
                            onChanged: onChanged,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.padding8),
                SizedBox(
                  width: Get.width * 0.6,
                  child: Text(
                    name,
                    maxLines: 2,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: TypographyResources.openSans,
                      fontSize: 10.r,
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.padding8),
                Row(
                  children: [
                    Visibility(
                      visible: isMeasBox == 1,
                      child: Icon(Icons.add, color: Colors.black, size: 20.r),
                    ),
                    inMyList == 1
                        ? SizedBox(height: 30.r)
                        : GestureDetector(
                          onTap: onTapIcon,
                          behavior: HitTestBehavior.opaque,
                          child: Image.asset(icon, height: 30.r),
                        ),
                  ],
                ),
                SizedBox(height: Dimensions.padding4),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
