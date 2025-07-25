import 'package:get/get.dart';
import 'package:quickb2b_v3_6/app/profile/profile_dashboard_controller.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';

extension ProfileDashboardDataservice on ProfileDashboardController {
  Future<void> getUserProfile() async {
    loading = true;
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = sharedPreferences.getString(Keys.acmCode);
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    // update();
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
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
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
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
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
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
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

  Future<void> updateProfile() async {
    loading = true;
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    payload.businessName = businessNameController.text;
    payload.firstName = firstNameController.text;
    payload.lastName = lastNameController.text;
    payload.phone = phoneController.text;
    payload.mobile = mobileController.text;
    payload.email = emailController.text;
    payload.deliveryNote = deliveryNoteController.text;
    await repository.updateProfile(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          // appUserGuide = response;
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

  Future<void> updateDeliveryAddressForBusiness() async {
    loading = true;
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    payload.deliveryStreetNumber = deliveryStreetNumberController.text;
    payload.deliverySuberb = deliverySuberbController.text;
    payload.deliveryCountry = deliveryCountryController.text;
    payload.deliveryStater = deliveryStaterController.text;
    payload.deliveryPostal = deliveryPostalController.text;

    await repository.updateBusinessDeliveryAddress(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          // appUserGuide = response;
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

  Future<void> updatePostalAdress() async {
    loading = true;
    ProfilePayload payload = ProfilePayload();
    payload.acmCode = "";
    payload.clientCode = GlobalConstants.clientCode;
    payload.deviceId = await GlobalConstants.getDeviceId();
    payload.userCode = sharedPreferences.getString(Keys.userCode);
    payload.postalStreetNumber = postalStreetNumberController.text;
    payload.postalSuberb = postalSuberbController.text;
    payload.postalCountry = postalCountryController.text;
    payload.postalStater = postalStaterController.text;
    payload.postalPostal = postalPostalController.text;
    await repository.updatePostalAddress(payload, (result, response, message) {
      switch (result) {
        case Result.onSuccess:
          loading = false;
          // appUserGuide = response;
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
