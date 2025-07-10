import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_payloads.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/past_order_model.dart';
import 'package:quickb2b_v3_6/network/data/response/profile_app_link.dart';
import 'package:quickb2b_v3_6/network/data/response/profile_app_user_guide.dart';
import 'package:quickb2b_v3_6/network/data/response/update_profile_model.dart';
import 'package:quickb2b_v3_6/network/data/response/user_profile_model.dart';
import 'package:quickb2b_v3_6/network/network_end_point.dart';
import 'package:quickb2b_v3_6/network/network_exception.dart';
import 'package:quickb2b_v3_6/network/network_manager.dart';

class ProfileDashboardRepository extends GetxController implements GetxService {
  NetworkManager network;
  ProfileDashboardRepository({required this.network});

  Future<void> getProfile(ProfilePayload payload, Function(Result result, UserProfileModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.getProfile, method: HTTPMethod.post, payload: NetworkPayload.userProfilePayload(payload: payload));
      try {
        final response = UserProfileModel.fromJson(networkResponse);
        print("Home Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> getPastOrders(ProfilePayload payload, Function(Result result, PastOrderModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.getUserOrders, method: HTTPMethod.post, payload: NetworkPayload.pastOrderPayload(payload: payload));
      try {
        final response = PastOrderModel.fromJson(networkResponse);
        print("Home Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> getLinks(ProfilePayload payload, Function(Result result, ProfileAppLinkModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.getLinkPost, method: HTTPMethod.post, payload: NetworkPayload.pastOrderPayload(payload: payload));
      try {
        final response = ProfileAppLinkModel.fromJson(networkResponse);
        print("Home Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> getAppUserGuide(ProfilePayload payload, Function(Result result, ProfileAppUserGuide? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.getAppUserguide, method: HTTPMethod.post, payload: NetworkPayload.pastOrderPayload(payload: payload));
      try {
        final response = ProfileAppUserGuide.fromJson(networkResponse);
        print("Home Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> updateProfile(ProfilePayload payload, Function(Result result, UpdateProfileModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.updateProfile, method: HTTPMethod.post, payload: NetworkPayload.updateProfilePayload(payload: payload));
      try {
        final response = UpdateProfileModel.fromJson(networkResponse);
        print("Home Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> updateBusinessDeliveryAddress(ProfilePayload payload, Function(Result result, UpdateProfileModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.updateBusinesDetails, method: HTTPMethod.post, payload: NetworkPayload.updateBusinessDeliveryPayload(payload: payload));
      try {
        final response = UpdateProfileModel.fromJson(networkResponse);
        print("Home Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> updatePostalAddress(ProfilePayload payload, Function(Result result, UpdateProfileModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.updatePostalAddress, method: HTTPMethod.post, payload: NetworkPayload.updatepostalAddressPayload(payload: payload));
      try {
        final response = UpdateProfileModel.fromJson(networkResponse);
        print("Home Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }
}
