import 'package:flutter/material.dart';
import 'package:quickb2b_v3_6/reusable/buttons.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';
import 'package:quickb2b_v3_6/utils/text_field.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Title Bar
            Container(
              height: 55,
              color: Colors.black,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(child: Center(child: Text('Create an account', style: TextStyle(color: Colors.white, fontSize: 20)))),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  spacing: Dimensions.padding10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Radio Group
                    customRadioButton(
                      labels: <String>[LocalText.forBusiness, LocalText.forHomeDelivery],
                      values: <String>["business", "home_delivery"],
                    ),

                    // Dropdown (Spinner)
                    dropDown(items: ['Region 1', 'Region 2', 'Region 3']),

                    // User Name Input
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.customerId),

                    // Info Text
                    Text('alphanumeric only, no spaces or special characters', style: TextStyle(color: Colors.black, fontSize: 12)),

                    // Password Fields
                    Row(
                      children: [
                        Expanded(child: customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.customerId)),
                        SizedBox(width: 10),
                        Expanded(child: customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.customerId)),
                      ],
                    ),

                    // Other Input FieldscustomTextField2(controller: TextEditingController(), textFieldLabel: LocalText.customerId),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.businessName),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.firstName),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.lastName),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.phone, keyboardType: TextInputType.phone),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.mobile, keyboardType: TextInputType.phone),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.email, keyboardType: TextInputType.emailAddress),

                    // Delivery Address Section
                    Text('Delivery Address', style: TextStyle(color: Colors.black, fontSize: 18)),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.numberslashStreet),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.suburbslashCity),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.country),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.stateslashRegion),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.postcodeslaShzip),

                    // Postal Address Section
                    customCheckedBox(text: LocalText.isPostalAddressSameAsDeliveryAddress),
                    Text('Postal Address', style: TextStyle(color: Colors.black, fontSize: 18)),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.numberslashStreet),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.suburbslashCity),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.country),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.stateslashRegion),
                    customTextField2(controller: TextEditingController(), textFieldLabel: LocalText.postcodeslaShzip),

                    // Submit Button
                    customButton2(textLabel: LocalText.submit, width: double.infinity, color: Colors.black, onPressed: () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
