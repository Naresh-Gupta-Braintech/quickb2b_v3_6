import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

extension MyListDataService on MyListController {
  Future<void> getUserItems(int reset) async {
    loading = true;
    MyListPayload payload = MyListPayload();
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    print("payload.userCode ${payload.userCode}");
    print("LocalStorage.getUserCode() ${await LocalStorage.getUserCode()}");
    payload.userCode = await LocalStorage.getUserCode();
    payload.reset = reset;
    await repository.getUserItems(payload, (result, response, message) async {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          myList = response;
          dataWithCategory = response?.dataWithCategory ?? [];
          var cart = await Get.find<LocalStorage>().getCartDetails();

          cart?.data?.allInventories?.forEach((element) {
            print("in my list dataservive cart item code :: ${element.itemCode} qty :: ${element.quantity}");
          });
          makeMyListFromLocalData();
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

  Future<void> removeFromMyList(String itemCode) async {
    loading = true;
    UserItemAddPayload payload = UserItemAddPayload();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    payload.itemCode = itemCode;
    payload.clientCode = GlobalConstants.clientCode;
    payload.appType = GlobalConstants.appType;
    payload.acmCode = "";
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.type = GlobalConstants.type;
    await repository.removeItemFromMyList(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          item = response;
          dataWithCategory?.forEach((category) {
            category.data?.removeWhere((product) => product.itemCode == itemCode);
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
