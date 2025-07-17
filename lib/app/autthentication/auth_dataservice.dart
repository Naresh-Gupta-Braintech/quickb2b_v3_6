import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

extension AuthDataservice on AuthController {
  Future<void> login() async {
    loading = true;
    update();
    LoginPayload payload = LoginPayload();
    payload.acmCode = "";
    payload.clientCode = "TK3757";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.username = userNameController.text.trim();
    payload.deviceToken =
        "ckIH3g7vQPayt65ik6tZvH:APA91bFrQWbVlDj44DZNTIzPUfoBdUYzX_xktROmHDtqqmeGW9f8HtUpmOb7MSjjUklOYjY2uv3t4j6jdaGjyJLvkaBNf4aGJ9zTPKC-Z6Q3xGIAz2zsGNg";
    payload.appType = "Dual";
    payload.deviceType = GlobalConstants.getDeviceType();
    payload.type = "Dual";
    payload.password = passwordController.text.trim();
    await repository.login(payload, (result, response, message) async {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          loginData = response;
          LocalStorage.saveLoginData(loginData);
          Get.find<SplashController>().init();
          break;
        case Result.onFailed:
          loading = false;
          update();
          Get.snackbar('Error', message ?? "error");
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
