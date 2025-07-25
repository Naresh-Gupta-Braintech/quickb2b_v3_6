import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_payloads.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/get_device_type_model.dart';
import 'package:quickb2b_v3_6/network/data/response/login_data.dart';
import 'package:quickb2b_v3_6/network/network_end_point.dart';
import 'package:quickb2b_v3_6/network/network_exception.dart';
import 'package:quickb2b_v3_6/network/network_manager.dart';

class AuthRepository extends GetxController implements GetxService {
  final NetworkManager network;
  AuthRepository({required this.network});

  Future<void> login(LoginPayload payload, Function(Result result, LoginData? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(
        endpoint: Endpoints.login,
        method: HTTPMethod.post,
        payload: NetworkPayload.loginPayload(payload: payload),
      );
      try {
        final response = LoginData.fromJson(networkResponse);
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

  // for registering the device id and user code
  Future<void> getDevice(GetDevicePayload payload, Function(Result result, GetDeviceTypeModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(
        endpoint: Endpoints.getDevice,
        method: HTTPMethod.post,
        payload: NetworkPayload.getDevicePayload(payload: payload),
      );
      try {
        final response = GetDeviceTypeModel.fromJson(networkResponse);
        completion((response.result == 1) ? Result.onSuccess : Result.onFailed, response, response.message);
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
