import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

extension HomeDataService on HomeController {
  Future<void> getHomeDetails() async {
    loading = true;
    update();
    HomeItemsPayload payload = HomeItemsPayload();
    payload.acmCode = "";
    payload.clientCode = "TK3757";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.userCode = "FGA";
    await repository.getHomeItems(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          homeItems = response;
          print("Naresh home controller :: ${homeItems?.status}");
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

  Future<void> getCompanyDetails() async {
    loading = true;
    update();
    HomeItemsPayload payload = HomeItemsPayload();
    payload.clientCode = "TK3757";
    payload.appType = "Dual";
    payload.type = "Dual";
    payload.userCode = "FGA";
    payload.deviceId = "a1ad67eaf5b9140f";
    await repository.getHomeItems(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          homeItems = response;
          Get.find<SplashController>().isCompanyDetailsFetchedSuccess = true;
          update();
          break;
        case Result.onFailed:
          loading = false;
          Get.snackbar('Error', message?.tr ?? "error");
          break;
        case Result.onException:
          loading = false;
          if (message != "cancelled") Get.snackbar('Error', message?.tr ?? "error");
          break;
      }
    });
  }

  Future<void> getCustomerDetails() async {
    loading = true;
    update();
    CustomerListPayload payload = CustomerListPayload();
    final loginData = await LocalStorage.getLoginData();
    payload.clientCode = "TK3757";
    payload.appType = "Dual";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.acmCode = loginData?.data?.acmCode;
    payload.search = "";
    await repository.getCustomers(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          customer = response;
          update();
          break;
        case Result.onFailed:
          loading = false;
          Get.snackbar('Error', message?.tr ?? "error");
          break;
        case Result.onException:
          loading = false;
          if (message != "cancelled") Get.snackbar('Error', message?.tr ?? "error");
          break;
      }
    });
  }

  Future<void> getOutlets() async {
    loading = true;
    update();
    OutletPayload payload = OutletPayload();
    final loginData = await LocalStorage.getLoginData();
    payload.clientCode = "TK3757";
    payload.appType = "Dual";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.acmCode = loginData?.data?.acmCode;
    payload.type = "Dual";
    payload.userCode = "QB2BDEV";
    await repository.getOutlets(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          outlet = response;
          update();
          break;
        case Result.onFailed:
          loading = false;
          Get.snackbar('Error', message?.tr ?? "error");
          break;
        case Result.onException:
          loading = false;
          if (message != "cancelled") Get.snackbar('Error', message?.tr ?? "error");
          break;
      }
    });
  }
}
