import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_controller.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/typofraphy_resources.dart';

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    super.initState();
    Get.find<ProfileDashboardController>().getProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileDashboardController>(
      builder: (controller) {
        final acm_code = controller.sharedPreferences.getString(Keys.acmCode);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding8),
          child: Scaffold(
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
                          _section(
                            isEditButtonVisible:
                                ((!controller.isEditCustomerDetailsSection) &&
                                    (acm_code != null && acm_code.isNotEmpty)),
                            text: "Customer Details",
                            onTap: () => {controller.makeCustomerEditable()},
                            buttonText: "Edit",
                          ),
                          SizedBox(height: Dimensions.viewHeight10),
                          // Customer ID
                          _customerDeatilsSection(
                            acm_code: acm_code,
                            isEdit:
                                (acm_code != null && acm_code.isNotEmpty) &&
                                controller.isEditCustomerDetailsSection,
                            onTap: () {
                              controller.makePCustomerReadOnly();
                            },
                            controller: controller,
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
                      controller: controller,
                    ),

                    SizedBox(height: Dimensions.viewHeight16),
                    _section(
                      text: "Postal Address",
                      onTap: () => {controller.makePostalEditable()},
                      buttonText: "Edit",
                      isEditButtonVisible:
                          ((!controller.isEditCustomerDetailsSection) &&
                              (acm_code != null && acm_code.isNotEmpty)),
                    ),
                    _postalAddressSection(
                      acm_code: acm_code,
                      isEdit:
                          (acm_code != null && acm_code.isNotEmpty) &&
                          controller.isEditPostalAddressSection,
                      onTap: () {
                        controller.makePostalReadOnly();
                      },
                      controller: controller,
                    ),

                    SizedBox(height: Dimensions.viewHeight16),

                    Visibility(
                      visible: (acm_code != null && acm_code.isNotEmpty),
                      child: Text(
                        "Delete Account",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: TypographyResources.openSans,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                          fontSize: Dimensions.font14,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.viewHeight16),

                    Visibility(
                      visible: (acm_code != null && acm_code.isNotEmpty),
                      child: Text(
                        "Change Password",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: TypographyResources.openSans,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: Dimensions.font14,
                        ),
                      ),
                    ),

                    // Progress Indicator
                    Visibility(
                      visible: false, 
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _customerDeatilsSection({
    String? acm_code,
    required bool isEdit,
    required VoidCallback onTap,
    required ProfileDashboardController controller,
  }) {
    final userData = controller.userProfile;
    return Column(
      children: [
        _buildInputRow(
          isEdit: isEdit,
          "Customer ID",
          userData?.data?.userCode ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.customerIdController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Business Name",
          userData?.data?.businessName ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.businessNameController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "First Name",
          userData?.data?.firstName ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.firstNameController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Last Name",
          userData?.data?.lastName ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.lastNameController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Phone",
          userData?.data?.phone ?? "",
          true,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.phoneController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Mobile",
          userData?.data?.mobile ?? "",
          true,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.mobileController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Email",
          userData?.data?.email ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.emailController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Delivery Note",
          userData?.data?.deliveryNote ?? "",
          true,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.deliveryNoteController,
        ),
        Visibility(visible: isEdit, child: _customButton(onTap: onTap)),
      ],
    );
  }

  Widget _deliveryAddressSection({
    required bool isEdit,
    required VoidCallback onTap,
    required ProfileDashboardController controller,
  }) {
    final userData = controller.userProfile;
    return Column(
      children: [
        _buildInputRow(
          isEdit: isEdit,
          "Number/Street",
          userData?.data?.deliveryAddress ?? "",
          false,
          enabledTextField: true,
          textController: controller.deliveryStreetNumberController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Suburb/City",
          userData?.data?.deliverySuburb ?? "",
          false,
          enabledTextField: true,
          textController: controller.deliverySuberbController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Country",
          userData?.data?.deliveryCountry ?? "",
          false,
          enabledTextField: true,
          textController: controller.deliveryCountryController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "State/Region",
          userData?.data?.deliveryState ?? "",
          false,
          enabledTextField: true,
          textController: controller.deliveryStaterController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Postcode/Zip",
          userData?.data?.deliveryPostCode ?? "",
          true,
          enabledTextField: true,
          textController: controller.deliveryPostalController,
        ),
        Visibility(visible: isEdit, child: _customButton(onTap: onTap)),
      ],
    );
  }

  Widget _postalAddressSection({
    String? acm_code,
    required bool isEdit,
    required VoidCallback onTap,
    required ProfileDashboardController controller,
  }) {
    final userData = controller.userProfile;

    return Column(
      children: [
        _buildInputRow(
          isEdit: isEdit,
          "Number/Street",
          userData?.data?.postalAddress ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.postalStreetNumberController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Suburb/City",
          userData?.data?.postalSuburb ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.postalSuberbController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Country",
          userData?.data?.postalCountry ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.postalCountryController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "State/Region",
          userData?.data?.postalState ?? "",
          false,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.postalStaterController,
        ),
        _buildInputRow(
          isEdit: isEdit,
          "Postcode/Zip",
          userData?.data?.postalPostCode ?? "",
          true,
          enabledTextField: (acm_code != null && acm_code.isNotEmpty),
          textController: controller.postalPostalController,
        ),
        Visibility(visible: isEdit, child: _customButton(onTap: onTap)),
      ],
    );
  }

  Widget _buildInputRow(
    String label,
    String value,
    bool isNumber, {
    required bool enabledTextField,
    required bool isEdit,
    required TextEditingController textController,
  }) {
    double width = Get.width;
    return GetBuilder<ProfileDashboardController>(
      builder: (controller) {
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

              Visibility(
                visible: !isEdit,
                child: Padding(
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
              ),
              Visibility(
                visible: isEdit,
                child: Padding(
                  padding: EdgeInsets.only(left: Dimensions.padding10),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    width: Get.width * 0.5,
                    child: TextField(
                      controller: textController,
                      style: TextStyle(fontSize: Dimensions.font12),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(bottom: 6.r),
                        constraints: BoxConstraints(maxHeight: 20.r),
                      ),
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

  Widget _section({
    required String text,
    VoidCallback? onTap,
    String? buttonText,
    required bool isEditButtonVisible,
  }) {
    double width = Get.width * 0.4;
    return Row(
      children: [
        SizedBox(
          width: width,
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: TypographyResources.openSans,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: Dimensions.font14,
            ),
          ),
        ),

        Visibility(
          visible: isEditButtonVisible,
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
                  color: Colors.teal,
                  fontSize: Dimensions.font14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customButton({required VoidCallback onTap}) {
    return Container(
      height: 30.r,
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.r))),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
