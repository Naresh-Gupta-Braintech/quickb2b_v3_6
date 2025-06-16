import 'package:flutter/material.dart';
import 'package:quickb2b_v3_6/utils/dimensions.dart';
import 'package:quickb2b_v3_6/utils/images.dart';
import 'package:quickb2b_v3_6/utils/local_text.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocalText.develop),

                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Image.asset(Images.cart, width: Dimensions.viewHeight40), Text("Total 0.00")],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 13, left: 5, right: 5),
              height: 100, // Set a fixed height or use a dynamic height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Replace with your data length
                itemBuilder: (context, index) {
                  return Container(
                    width: 100, // Set width for each item
                    color: Colors.grey, // Replace with your item color
                    child: Center(child: Text('Item $index')),
                  );
                },
              ),
            ),

            // FragmentContainerView equivalent
            // Expanded(
            //   child: Container(
            //     margin: EdgeInsets.only(top: 13),
            //     child: Navigator(
            //       // Replace with your navigation logic
            //       onGenerateRoute: (RouteSettings settings) {
            //         // Define your routes here
            //         return MaterialPageRoute(builder: (context) => Placeholder());
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
