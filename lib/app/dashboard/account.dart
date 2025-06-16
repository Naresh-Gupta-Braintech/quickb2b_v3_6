import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Customer Details Section
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer Details Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Customer Details", style: TextStyle(fontFamily: 'OpenSansBold', color: Colors.black, fontSize: 14)),
                      Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.transparent, // Invisible
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),

                  // Customer ID
                  _buildInputRow("Customer ID", "Enter Customer ID", false),
                  _buildInputRow("Business Name", "Enter Business Name", false),
                  _buildInputRow("First Name", "Enter First Name", false),
                  _buildInputRow("Last Name", "Enter Last Name", false),
                  _buildInputRow("Phone", "Enter Phone", true),
                  _buildInputRow("Mobile", "Enter Mobile", true),
                  _buildInputRow("Email", "Enter Email", false),
                  _buildInputRow("Delivery Note", "Enter Delivery Note", true),
                ],
              ),
            ),

            // Save Button
            Container(
              margin: EdgeInsets.only(top: 5, right: 10),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Save action
                },
                style: ElevatedButton.styleFrom(
                  // primary: Colors.blue, // Background color
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                ),
                child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ),

            // Delivery Address Section
            _buildAddressSection("Delivery Address"),
            _buildAddressSection("Postal Address"),

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

  Widget _buildInputRow(String label, String hint, bool isNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'OpenSansBold', color: Colors.black, fontSize: 15)),
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: hint, border: OutlineInputBorder()),
              keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(String title) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontFamily: 'OpenSansBold', color: Colors.black, fontSize: 18)),
          // Add address fields here
          _buildInputRow("Number/Street", "Enter Number/Street", false),
          _buildInputRow("Suburb/City", "Enter Suburb/City", false),
          _buildInputRow("Country", "Enter Country", false),
          _buildInputRow("State/Region", "Enter State/Region", false),
          _buildInputRow("Postcode/Zip", "Enter Postcode/Zip", true),
        ],
      ),
    );
  }
}
