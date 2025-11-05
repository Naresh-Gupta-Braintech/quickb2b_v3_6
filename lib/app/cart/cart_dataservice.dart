import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/cart/cart_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

extension CartDataservice on CartController {
  Future<void> getCart() async {
    loading = true;
    print("userCode :: ${sharedPreferences.getString(Keys.userCode)}");
    CartPayload payload = CartPayload();
    payload.acmCode = "";
    payload.appType = "Dual";
    payload.type = "Dual";
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    await repository.getCartList(payload, (result, response, message) async {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          isCartFetchedSuccess = true;
          cartData = response;
          await LocalStorage.saveCartDetails(cartData);
          calculateCartPrice();
          var savedCart = await Get.find<LocalStorage>().getCartDetails();

          int index = 0;
          savedCart?.data?.allInventories?.forEach((element) {
            print("saved cart item code :: ${element.itemCode} qty :: ${element.quantity} index :: ${index++}");
          });

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
