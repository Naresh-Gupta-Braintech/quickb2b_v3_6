import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/autthentication/auth_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/reusable/custom_toast.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

extension AuthDataservice on AuthController {
  Future<void> login(BuildContext context) async {
    // "a1ad67eaf5b9140f"
    loading = true;
    update();
    LoginPayload payload = LoginPayload();
    payload.acmCode = "";
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.username = userNameController.text.trim();
    payload.deviceToken = "ckIH3g7vQPayt65ik6tZvH:APA91bFrQWbVlDj44DZNTIzPUfoBdUYzX_xktROmHDtqqmeGW9f8HtUpmOb7MSjjUklOYjY2uv3t4j6jdaGjyJLvkaBNf4aGJ9zTPKC-Z6Q3xGIAz2zsGNg";
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
          showToast(context);
          loginRoutes();

          print("get device call success");
          print("login success");
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

  Future<void> getDevice() async {
    loading = true;
    Get.find<AuthController>().loading = true;
    GetDevicePayload payload = GetDevicePayload();
    payload.acmCode = "";
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.deviceToken = "ckIH3g7vQPayt65ik6tZvH:APA91bFrQWbVlDj44DZNTIzPUfoBdUYzX_xktROmHDtqqmeGW9f8HtUpmOb7MSjjUklOYjY2uv3t4j6jdaGjyJLvkaBNf4aGJ9zTPKC-Z6Q3xGIAz2zsGNg";
    payload.appType = "Dual";
    payload.deviceType = GlobalConstants.getDeviceType();
    payload.type = "Dual";
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    payload.deviceModel = await GlobalConstants.getDeviceModel() ?? "";
    payload.ipAddress = await GlobalConstants.checkConnectionType() ?? "";

    await repository.getDevice(payload, (result, response, message) async {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          Get.find<AuthController>().loading = false;
          deviceData = response;
          LocalStorage.saveDeviceData(response);
          isGetDeviceFetchCompleted = true;
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
