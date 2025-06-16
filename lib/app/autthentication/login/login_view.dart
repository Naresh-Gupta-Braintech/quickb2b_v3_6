import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/reusable/buttons.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Images.login, fit: BoxFit.fitHeight, height: Get.height),
          SafeArea(
            // bottom: ,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 48), child: Image.asset(Images.logo)),
                      Spacer(),
                      customTextField(controller: TextEditingController(), textFieldLabel: "User Id"),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 8),
                        child: customObsecureTextField(controller: TextEditingController(), textFieldLabel: "Password", obsecureText: true),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 8), child: customButton(textLabel: "Login")),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black,
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Get.toNamed(RoutesHelper.forgot),
                        child: Text('Forgot password', style: TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Get.toNamed(RoutesHelper.register),
                        child: Text('Access your account', style: TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.center),
                      ),
                    ],
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
