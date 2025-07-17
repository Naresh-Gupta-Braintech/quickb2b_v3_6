import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';

extension CartDataservice on CartController {
  Future<void> getCart() async {
    loading = true;
    CartPayload payload = CartPayload();
    payload.acmCode = "";
    payload.appType = "Dual";
    payload.type = "Dual";
    payload.userCode = "FGA";
    payload.clientCode = "TK3757";
    payload.deviceId = "a1ad67eaf5b9140f";
    await repository.getCartList(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          Get.find<SplashController>().isCartFetchedSuccess = true;
          cartData = response;
          print("Naresh home controller :: ${cartData?.status}");
          update();
          break;
        case Result.onFailed:
          loading = false;
          update();
          Get.snackbar('Error', message?.tr ?? "error");
          break;
        case Result.onException:
          loading = false;
          update();
          if (message != "cancelled") Get.snackbar('Error', message?.tr ?? "error");
          break;
      }
    });
  }
}
