import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/home/home_repository.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController implements GetxService {
  HomeController({required this.sharedPreferences, required this.repository});
  SharedPreferences sharedPreferences;
  HomeRepository repository;
  bool loading = false;
  HomeItemsData? homeItems;

  void gethomeItems() {
    getHomeDetails();
  }

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
}
