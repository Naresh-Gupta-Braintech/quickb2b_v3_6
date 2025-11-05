import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart' show ToastGravity, FToast;
import 'package:quickb2b_v3_6/utils/images.dart';

showToast(BuildContext context, {FToast? ftoast}) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: Colors.grey.withAlpha(125)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Image.asset(Images.appLogo), SizedBox(width: 12.0), Text("Logged in Successfully", style: TextStyle(color: Colors.white, fontSize: 16.r, fontWeight: FontWeight.w600))],
    ),
  );

  ftoast?.showToast(child: toast, gravity: ToastGravity.BOTTOM, toastDuration: Duration(seconds: 2));
}
