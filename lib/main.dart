import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/helper/get_directory.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const QuickB2b());
}

class QuickB2b extends StatelessWidget {
  const QuickB2b({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String loginData = Get.find<AuthController>().sharedPreferences.getString(Keys.loginData) ?? "";
    String initialRoute = RoutesHelper.login;
    if (loginData.isNotEmpty) {
      initialRoute = RoutesHelper.home;
    }
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(debugShowCheckedModeBanner: false, getPages: RoutesHelper.getRoutes(), initialRoute: initialRoute);
      },
    );
  }
}
