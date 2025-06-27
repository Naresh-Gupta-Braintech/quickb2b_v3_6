import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customLoader() {
  return Container(height: Get.height, width: Get.height, color: Colors.transparent, child: Center(child: CircularProgressIndicator(color: Colors.blue[300])));
}
