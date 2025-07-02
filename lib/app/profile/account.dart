import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.padding16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer Details Title
                  _section(text: "Customer Details"),
                  SizedBox(height: Dimensions.viewHeight16),

                  // Customer ID
                  _buildInputRow(isEditable: false, "Customer ID", "Enter Customer ID", false),
                  _buildInputRow(isEditable: false, "Business Name", "Enter Business Name", false),
                  _buildInputRow(isEditable: false, "First Name", "Enter First Name", false),
                  _buildInputRow(isEditable: false, "Last Name", "Enter Last Name", false),
                  _buildInputRow(isEditable: false, "Phone", "Enter Phone", true),
                  _buildInputRow(isEditable: false, "Mobile", "Enter Mobile", true),
                  _buildInputRow(isEditable: false, "Email", "Enter Email", false),
                  _buildInputRow(isEditable: false, "Delivery Note", "Enter Delivery Note", true),
                ],
              ),
            ),

            // Save Button
            SizedBox(height: Dimensions.viewHeight16),

            // Delivery Address Section
            _section(text: "Delivery Address", onTap: () => {}, buttonText: "Edit"),
            _buildInputRow(isEditable: false, "Number/Street", "Enter Number/Street", false),
            _buildInputRow(isEditable: false, "Suburb/City", "Enter Suburb/City", false),
            _buildInputRow(isEditable: false, "Country", "Enter Country", false),
            _buildInputRow(isEditable: false, "State/Region", "Enter State/Region", false),
            _buildInputRow(isEditable: false, "Postcode/Zip", "Enter Postcode/Zip", true),

            SizedBox(height: Dimensions.viewHeight16),
            _section(text: "Postal Address"),
            _buildInputRow(isEditable: false, "Number/Street", "Enter Number/Street", false),
            _buildInputRow(isEditable: false, "Suburb/City", "Enter Suburb/City", false),
            _buildInputRow(isEditable: false, "Country", "Enter Country", false),
            _buildInputRow(isEditable: false, "State/Region", "Enter State/Region", false),
            _buildInputRow(isEditable: false, "Postcode/Zip", "Enter Postcode/Zip", true),

            // Progress Indicator
            Visibility(
              visible: false, // Change to true to show
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputRow(String label, String value, bool isNumber, {required bool isEditable}) {
    double width = Get.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.4,
            child: Text(
              label,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: TypographyResources.openSans,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: Dimensions.font14,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: Dimensions.padding10),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: TypographyResources.openSans,
                color: Colors.grey,
                fontSize: Dimensions.font12,
                fontWeight: FontWeight.w600,
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
  }

  Widget _section({required String text, VoidCallback? onTap, String? buttonText}) {
    double width = Get.width * 0.4;
    return Row(
      children: [
        SizedBox(
          width: width,
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.black, fontSize: Dimensions.font14),
          ),
        ),

        Visibility(
          visible: onTap != null,
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.padding10),
            child: InkWell(
              onTap: onTap,
              child: Text(
                buttonText ?? "",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: TypographyResources.openSans,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                  fontSize: Dimensions.font14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
