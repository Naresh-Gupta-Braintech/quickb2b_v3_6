import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Expanded(
                    child: Center(child: Text('Forgot Password', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'AcuminBold'))),
                  ),
                ],
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Supplier Name Text
                  Text('', style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'AcuminRegular')),

                  // Spinner (Dropdown)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Select Region'),
                      items:
                          <String>['Region 1', 'Region 2', 'Region 3'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(value: value, child: Text(value));
                          }).toList(),
                      onChanged: (String? newValue) {},
                    ),
                  ),

                  // Email Input
                  TextField(
                    decoration: InputDecoration(hintText: 'Customer ID', contentPadding: EdgeInsets.all(10), border: OutlineInputBorder()),
                    style: TextStyle(fontSize: 14, fontFamily: 'AcuminRegular'),
                  ),

                  // Continue Button
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle continue action
                      },
                      child: Text('Continue', style: TextStyle(color: Colors.white, fontFamily: 'AcuminBold')),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        // primary: Colors.blue, // Background color
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progress Indicator
            Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
