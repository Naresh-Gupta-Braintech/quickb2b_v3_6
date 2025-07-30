import 'package:flutter/material.dart';
import 'package:quickb2b_v3_6/reusable/dialog.dart';

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(child: showAlert(onPressed: () {}, buttonText: "procedd", description: "lohfdsgdsfgdhfghf", showCancelBtn: false)),
      ),
    );
  }
}
