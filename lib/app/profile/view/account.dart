import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_controller.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class Account extends StatelessWidget {
  Account({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileDashboardController>(
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
                        _section(isEditButtonVisible: ((!controller.isEditCustomerDetailsSection) && (acm_code != null && acm_code.isNotEmpty)), text: "Customer Details", onTap: () => {controller.makeCustomerEditable()}, buttonText: "Edit"),
                        SizedBox(height: Dimensions.viewHeight10),
                        // Customer ID
                        _customerDeatilsSection(
                          acm_code: acm_code,
                          isEdit: (acm_code != null && acm_code.isNotEmpty) && controller.isEditCustomerDetailsSection,
                          onTap: () {
                            controller.makePCustomerReadOnly();
                          },
                        ),
                      ],
                    ),
                  ),

                  // Save Button
                  SizedBox(height: Dimensions.viewHeight16),

                  // Delivery Address Section
                  _section(
                    text: "Delivery Address",
                    onTap: () {
                      controller.makeDeliveryEditable();
                    },
                    buttonText: "Edit",
                    isEditButtonVisible: ((!controller.isEditDeliverSection)),
                  ),

                  _deliveryAddressSection(
                    isEdit: controller.isEditDeliverSection,
                    onTap: () {
                      controller.makeDeliveryReadOnly();
                    },
                  ),

                  SizedBox(height: Dimensions.viewHeight16),
                  _section(text: "Postal Address", onTap: () => {controller.makePostalEditable()}, buttonText: "Edit", isEditButtonVisible: ((!controller.isEditCustomerDetailsSection) && (acm_code != null && acm_code.isNotEmpty))),
                  _postalAddressSection(
                    acm_code: acm_code,
                    isEdit: (acm_code != null && acm_code.isNotEmpty) && controller.isEditPostalAddressSection,
                    onTap: () {
                      controller.makePostalReadOnly();
                    },
                  ),

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

  Widget _customerDeatilsSection({String? acm_code, required bool isEdit, required VoidCallback onTap}) {
    return Column(
      children: [
        _buildInputRow(isEdit: isEdit, "Customer ID", "Enter Customer ID", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Business Name", "Enter Business Name", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "First Name", "Enter First Name", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Last Name", "Enter Last Name", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Phone", "Enter Phone", true, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Mobile", "Enter Mobile", true, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Email", "Enter Email", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Delivery Note", "Enter Delivery Note", true, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        Visibility(visible: isEdit, child: _customButton(onTap: onTap)),
      ],
    );
  }

  Widget _deliveryAddressSection({required bool isEdit, required VoidCallback onTap}) {
    return Column(
      children: [
        _buildInputRow(isEdit: isEdit, "Number/Street", "Enter Number/Street", false, enabledTextField: true),
        _buildInputRow(isEdit: isEdit, "Suburb/City", "Enter Suburb/City", false, enabledTextField: true),
        _buildInputRow(isEdit: isEdit, "Country", "Enter Country", false, enabledTextField: true),
        _buildInputRow(isEdit: isEdit, "State/Region", "Enter State/Region", false, enabledTextField: true),
        _buildInputRow(isEdit: isEdit, "Postcode/Zip", "Enter Postcode/Zip", true, enabledTextField: true),
        Visibility(visible: isEdit, child: _customButton(onTap: onTap)),
      ],
    );
  }

  Widget _postalAddressSection({String? acm_code, required bool isEdit, required VoidCallback onTap}) {
    return Column(
      children: [
        _buildInputRow(isEdit: isEdit, "Number/Street", "Enter Number/Street", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Suburb/City", "Enter Suburb/City", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Country", "Enter Country", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "State/Region", "Enter State/Region", false, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        _buildInputRow(isEdit: isEdit, "Postcode/Zip", "Enter Postcode/Zip", true, enabledTextField: (acm_code != null && acm_code.isNotEmpty)),
        Visibility(visible: isEdit, child: _customButton(onTap: onTap)),
      ],
    );
  }

  Widget _buildInputRow(String label, String value, bool isNumber, {required bool enabledTextField, required bool isEdit}) {
    double width = Get.width;
    return GetBuilder<ProfileDashboardController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SizedBox(width: width * 0.4, child: Text(label, textAlign: TextAlign.right, style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.black, fontSize: Dimensions.font14))),

              Visibility(visible: !isEdit, child: Padding(padding: EdgeInsets.only(left: Dimensions.padding10), child: Text(value, style: TextStyle(fontFamily: TypographyResources.openSans, color: Colors.grey, fontSize: Dimensions.font12, fontWeight: FontWeight.w600)))),
              Visibility(
                visible: isEdit,
                child: Padding(
                  padding: EdgeInsets.only(left: Dimensions.padding10),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    width: Get.width * 0.5,
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
            ],
          ),
        );
      },
    );
  }

  Widget _section({required String text, VoidCallback? onTap, String? buttonText, required bool isEditButtonVisible}) {
    double width = Get.width * 0.4;
    return Row(
      children: [
        SizedBox(width: width, child: Text(text, textAlign: TextAlign.right, style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.black, fontSize: Dimensions.font14))),

        Visibility(
          visible: isEditButtonVisible,
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.padding10),
            child: InkWell(onTap: onTap, child: Text(buttonText ?? "", textAlign: TextAlign.right, style: TextStyle(fontFamily: TypographyResources.openSans, fontWeight: FontWeight.w700, color: Colors.teal, fontSize: Dimensions.font14))),
          ),
        ),
      ],
    );
  }

  Widget _customButton({required VoidCallback onTap}) {
    return Container(
      height: 30.r,
      alignment: Alignment.bottomRight,
      child: ElevatedButton(onPressed: () => {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.r)))), child: GestureDetector(onTap: onTap, child: Text("Save", style: TextStyle(color: Colors.white)))),
    );
  }
}
