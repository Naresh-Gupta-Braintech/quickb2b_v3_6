import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/reusable/buttons.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/text_field.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(onTap: Get.back, child: Icon(Icons.arrow_back, color: Colors.white)),
        backgroundColor: Colors.black,
        title: Text(
          LocalText.forgotPassword,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontFamily: TypographyResources.acumin, fontWeight: FontWeight.w600, fontSize: Dimensions.font20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.padding16, Dimensions.padding40, Dimensions.padding16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.customerId),
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.padding16),
                  child: customButton2(
                    textLabel: LocalText.continueText.toUpperCase(),
                    width: double.infinity,
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
