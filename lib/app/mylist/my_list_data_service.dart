import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/mylist/my_list_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';

extension MyListDataService on MyListController {
  Future<void> getUserItems(int reset) async {
    loading = true;
    MyListPayload payload = MyListPayload();

    payload.clientCode = "TK3757";
    payload.deviceId = "a1ad67eaf5b9140f";
    payload.userCode = "FGA";
    payload.reset = reset;
    await repository.getUserItems(payload, (result, response, message) {
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
