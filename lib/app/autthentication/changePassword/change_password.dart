import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
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
                    child: Center(child: Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'AcuminBold'))),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Password Input
                    _buildPasswordInput('Password', 'input_password'),

                    // New Password Input
                    _buildPasswordInput('New Password', 'input_new_password'),

                    // Confirm Password Input
                    _buildPasswordInput('Confirm Password', 'input_confirm_password'),

                    // Save Button
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle save action
                        },
                        child: Text('SAVE', style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'AcuminBold')),
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.black,
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ),

                    // Progress Indicator
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordInput(String hint, String id) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: hint, contentPadding: EdgeInsets.all(10), border: OutlineInputBorder()),
              obscureText: true,
              style: TextStyle(fontFamily: 'AcuminRegular'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.visibility_off), // Change icon based on visibility state
            onPressed: () {
              // Handle password visibility toggle
            },
          ),
        ],
      ),
    );
  }
}
