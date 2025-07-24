import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_controller.dart';
import 'package:quickb2b_v3_6/app/splash/splash_controller.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/customer_list.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
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
          initializeController();
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
    await repository.getCompanyDetails(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          companyDetails = response;
          LocalStorage.saveCompanyDetails(companyDetails);
          sharedPreferences.setString(Keys.appName, response?.data?.appName ?? "");
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

  Future<void> getCustomers() async {
    loading = true;
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
          customers = response;
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
    payload.deviceId = "dae303720ab0e176";
    payload.acmCode = loginData?.data?.acmCode ?? "";
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

  Future<void> getCustomersDetails(SingleCustmer customer) async {
    loading = true;
    update();
    CustomerPayload payload = CustomerPayload();
    final loginData = await LocalStorage.getLoginData();
    payload.clientCode = "TK3757";
    payload.appType = "Dual";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.acmCode = loginData?.data?.acmCode;
    payload.userCode = customer.customerCode;
    await repository.getCustomerDetails(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          customerDetails = response;
          LocalStorage.saveCustomerDeatils(customerDetails);
          LocalStorage.setUserCode(customerDetails?.data?.userCode ?? "");
          final customerData = LocalStorage.getCustomerDetails();
          if (customerData != null) {
            Get.offAllNamed(RoutesHelper.home);
          }
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
