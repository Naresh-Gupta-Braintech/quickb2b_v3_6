import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/product/product_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

extension ProductDataservice on ProductController {
  Future<void> getCategories() async {
    loading = true;
    CategoryPayload payload = CategoryPayload();
    final loginData = await LocalStorage.getLoginData();
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.acmCode = loginData?.data?.acmCode;
    payload.userCode = sharedPreferences.getString(Keys.userCode);

    await repository.getAllCategories(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          categories = response;
          update();
          getAllProductByCategory(categories?.categories?[0].id ?? "");
          if (categories != null && categories?.categories?.length != 0) {
            // getAllProductByCategory(categories?.categories?[0].id ?? "");
          }

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

  Future<void> getAllProductByCategory(String categoryId) async {
    loading = true;
    ProductPayload payload = ProductPayload();
    final loginData = await LocalStorage.getLoginData();
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.acmCode = loginData?.data?.acmCode;
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    payload.categoryId = categoryId;
    payload.page = page;
    await repository.searchProductByCategory(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          productdata = response;
          if (categoryId == previousCategory) {
            final invontry = response?.data?.inventoriesList ?? [];
            productsInventry.addAll(invontry);
          } else {
            productsInventry = response?.data?.inventoriesList ?? [];
          }
          previousCategory = categoryId;
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

Future<void> addItemsToMYList(String itemCode) async {
    loading = true;
    UserItemAddPayload payload = UserItemAddPayload();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    payload.itemCode = itemCode;
    payload.clientCode = GlobalConstants.clientCode;
    payload.appType = GlobalConstants.appType;
    payload.acmCode = "";
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.type = GlobalConstants.type;
    await repository.addToMyList(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
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
