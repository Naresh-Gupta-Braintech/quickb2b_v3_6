import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_payloads.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/login_data.dart';
import 'package:quickb2b_v3_6/network/network_end_point.dart';
import 'package:quickb2b_v3_6/network/network_exception.dart';
import 'package:quickb2b_v3_6/network/network_manager.dart';
import 'package:quickb2b_v3_6/network/network_response.dart';

class AuthRepository extends GetxController implements GetxService {
  final NetworkManager network;
  AuthRepository({required this.network});

  Future<void> login(LoginPayload payload, Function(Result result, NetworkResponse<LoginData>? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.login, method: HTTPMethod.post, payload: NetworkPayload.loginPayload(payload: payload));
      try {
        final response = NetworkResponse.fromJson(networkResponse, (json) {
          // print("Naresh :: $json");
          return LoginData.fromJson(json);
        });
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
