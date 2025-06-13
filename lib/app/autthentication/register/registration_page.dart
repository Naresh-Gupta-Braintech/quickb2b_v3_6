import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
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
                  Expanded(child: Center(child: Text('Create an account', style: TextStyle(color: Colors.white, fontSize: 20)))),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Radio Group
                    Column(
                      children: [
                        ListTile(
                          title: Text('For Business', style: TextStyle(color: Colors.green, fontSize: 16)),
                          leading: Radio(value: 'business', groupValue: 'selected', onChanged: (value) {}),
                        ),
                        ListTile(
                          title: Text('For Home Delivery', style: TextStyle(color: Colors.black, fontSize: 16)),
                          leading: Radio(value: 'home_delivery', groupValue: 'selected', onChanged: (value) {}),
                        ),
                      ],
                    ),

                    // Dropdown (Spinner)
                    Container(
                      margin: EdgeInsets.only(top: 10),
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

                    // User Name Input
                    TextField(
                      decoration: InputDecoration(hintText: 'Customer ID', contentPadding: EdgeInsets.all(10)),
                      textCapitalization: TextCapitalization.characters,
                    ),

                    // Info Text
                    Text('alphanumeric only, no spaces or special characters', style: TextStyle(color: Colors.black, fontSize: 12)),

                    // Password Fields
                    Row(
                      children: [
                        Expanded(
                          child: TextField(decoration: InputDecoration(hintText: 'Password', contentPadding: EdgeInsets.all(10)), obscureText: true),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(hintText: 'Confirm Password', contentPadding: EdgeInsets.all(10)),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),

                    // Other Input Fields
                    TextField(decoration: InputDecoration(hintText: 'Business Name', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'First Name', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'Last Name', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'Phone', contentPadding: EdgeInsets.all(10)), keyboardType: TextInputType.phone),
                    TextField(decoration: InputDecoration(hintText: 'Mobile', contentPadding: EdgeInsets.all(10)), keyboardType: TextInputType.phone),
                    TextField(
                      decoration: InputDecoration(hintText: 'Email', contentPadding: EdgeInsets.all(10)),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    // Delivery Address Section
                    Text('Delivery Address', style: TextStyle(color: Colors.black, fontSize: 18)),
                    TextField(decoration: InputDecoration(hintText: 'Number/Street', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'Suburb/City', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'Country', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'State/Region', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'Postcode/Zip', contentPadding: EdgeInsets.all(10))),

                    // Postal Address Section
                    CheckboxListTile(
                      title: Text('Is postal address same as delivery address?', style: TextStyle(color: Colors.black)),
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    Text('Postal Address', style: TextStyle(color: Colors.black, fontSize: 18)),
                    TextField(decoration: InputDecoration(hintText: 'Number/Street', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'Suburb/City', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'Country', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'State/Region', contentPadding: EdgeInsets.all(10))),
                    TextField(decoration: InputDecoration(hintText: 'Postcode/Zip', contentPadding: EdgeInsets.all(10))),

                    // Submit Button
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle submit action
                        },
                        child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 13)),
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.black,
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
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
