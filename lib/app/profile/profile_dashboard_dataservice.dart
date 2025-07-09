import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';

extension ProfileDashboardDataservice on ProfileDashboardController {
  Future<void> getUserProfile() async {
    loading = true;
    update();
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = "TK3757";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.userCode = "FGA";
    await repository.getProfile(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          userProfile = response;
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

  Future<void> getPastUserOrder() async {
    loading = true;
    update();
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = "TK3757";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.userCode = "FGA";
    await repository.getPastOrders(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          pastOrder = response;
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

  Future<void> getLinks() async {
    loading = true;
    update();
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = "TK3757";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.userCode = "FGA";
    await repository.getLinks(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          links = response;
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

  Future<void> getAppUserGuide() async {
    loading = true;
    update();
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = "TK3757";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.userCode = "FGA";
    await repository.getAppUserGuide(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          appUserGuide = response;
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
