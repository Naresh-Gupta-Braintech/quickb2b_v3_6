import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/profile/dashboard_controller.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class Account extends StatelessWidget {
  Account({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        final acm_code = controller.sharedPreferences.getString(Keys.acmCode);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.r),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimensions.padding16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Customer Details Title
                        (acm_code != null && acm_code.isNotEmpty) ? _section(text: "Customer Details", onTap: () => {}, buttonText: "Edit") : _section(text: "Customer Details"),
                        SizedBox(height: Dimensions.viewHeight10),

                        // Customer ID
                        _buildInputRow("Customer ID", "Enter Customer ID", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                        _buildInputRow("Business Name", "Enter Business Name", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                        _buildInputRow("First Name", "Enter First Name", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                        _buildInputRow("Last Name", "Enter Last Name", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                        _buildInputRow("Phone", "Enter Phone", true, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                        _buildInputRow("Mobile", "Enter Mobile", true, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                        _buildInputRow("Email", "Enter Email", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                        _buildInputRow("Delivery Note", "Enter Delivery Note", true, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                      ],
                    ),
                  ),

                  // Save Button
                  SizedBox(height: Dimensions.viewHeight16),

                  // Delivery Address Section
                  _section(
                    text: "Delivery Address",
                    onTap: () {
                      controller.showIsEdit();
                    },
                    buttonText: "Edit",
                  ),
                  _buildInputRow("Number/Street", "Enter Number/Street", false, enabledTextField: true),
                  _buildInputRow("Suburb/City", "Enter Suburb/City", false, enabledTextField: true),
                  _buildInputRow("Country", "Enter Country", false, enabledTextField: true),
                  _buildInputRow("State/Region", "Enter State/Region", false, enabledTextField: true),
                  _buildInputRow("Postcode/Zip", "Enter Postcode/Zip", true, enabledTextField: true),

                  SizedBox(height: Dimensions.viewHeight16),
                  (acm_code != null && acm_code.isNotEmpty) ? _section(text: "Postal Address", onTap: () => {}, buttonText: "Edit") : _section(text: "Postal Address"),
                  _buildInputRow("Number/Street", "Enter Number/Street", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                  _buildInputRow("Suburb/City", "Enter Suburb/City", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                  _buildInputRow("Country", "Enter Country", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                  _buildInputRow("State/Region", "Enter State/Region", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
                  _buildInputRow("Postcode/Zip", "Enter Postcode/Zip", true, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),

                  SizedBox(height: Dimensions.viewHeight16),

                  Visibility(visible: (acm_code != null && acm_code.isNotEmpty), child: Text("Delete Account", textAlign: TextAlign.right, style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.red, fontSize: Dimensions.font14))),
                  Visibility(visible: (acm_code != null && acm_code.isNotEmpty), child: Text("Change Password", textAlign: TextAlign.right, style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.black, fontSize: Dimensions.font14))),

                  // Progress Indicator
                  Visibility(
                    visible: false, // Change to true to show
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputRow(String label, String value, bool isNumber, {required bool enabledTextField}) {
    double width = Get.width;
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SizedBox(width: width * 0.4, child: Text(label, textAlign: TextAlign.right, style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.black, fontSize: Dimensions.font14))),

              Visibility(visible: !controller.isEdit, child: Padding(padding: EdgeInsets.only(left: Dimensions.padding10), child: Text(value, style: TextStyle(fontFamily: TypographyResources.openSans, color: Colors.grey, fontSize: Dimensions.font12, fontWeight: FontWeight.w600)))),
              Visibility(
                visible: enabledTextField && controller.isEdit,
                child: Padding(
                  padding: EdgeInsets.only(left: Dimensions.padding10),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    width: Get.width * 0.3,
                    child: TextField(
                      style: TextStyle(fontSize: Dimensions.font12),
                      decoration: InputDecoration(isDense: true, contentPadding: EdgeInsets.only(bottom: 6.r), constraints: BoxConstraints(maxHeight: 20.r)),
                      cursorHeight: 10.r,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: Dimensions.padding10),
              //   child: SizedBox(width: (width * 0.5), child: customTextField2(controller: TextEditingController(), textFieldLabel: "")),
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget _section({required String text, VoidCallback? onTap, String? buttonText}) {
    double width = Get.width * 0.4;
    return Row(
      children: [
        SizedBox(width: width, child: Text(text, textAlign: TextAlign.right, style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.black, fontSize: Dimensions.font14))),

        Visibility(
          visible: onTap != null,
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.padding10),
            child: InkWell(onTap: onTap, child: Text(buttonText ?? "", textAlign: TextAlign.right, style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.green, fontSize: Dimensions.font14))),
          ),
        ),
      ],
    );
  }
}
