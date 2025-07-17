import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_list.dart';
import 'package:quickb2b_v3_6/reusable/header.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({super.key});

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().getCustomersList();
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
        headerWithSearch(
          showOutlet: false,
          isSearchBarFull: true,
          showPrice: 0,
          rightText: "Add Customers",
          hint: "Search all Customers",
          textAlignment: TextAlign.center,
          appName: "",
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: ListView.builder(
              itemCount: controller.customers?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.customerDetail(controller.customers?.data?[index] ?? SingleCustmer());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.padding8),
                        child: Text(
                          "${controller.customers?.data?[index].businessName ?? ""} - ${controller.customers?.data?[index].deliverySuburb}",
                        ),
                      ),
                    ),
                    Divider(thickness: 0.5),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
