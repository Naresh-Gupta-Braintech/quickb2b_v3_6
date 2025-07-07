import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({super.key});

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(backgroundColor: Colors.white, body: SafeArea(child: _body(controller)));
      },
    );
  }

  Widget _body(HomeController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        headerWithSearch(showOutlet: false, isSearchBarFull: true, showPrice: 0, rightText: "Add Customers"),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: ListView.builder(
              itemCount: controller.customers.length,
              itemBuilder: (context, index) {
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(controller.customers[index]), Divider()]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
