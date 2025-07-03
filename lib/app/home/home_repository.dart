import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_payloads.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/company_details_data.dart';
import 'package:quickb2b_v3_6/network/data/response/home_items_data.dart';
import 'package:quickb2b_v3_6/network/network_end_point.dart';
import 'package:quickb2b_v3_6/network/network_exception.dart';
import 'package:quickb2b_v3_6/network/network_manager.dart';

class HomeRepository extends GetxController implements GetxService {
  final NetworkManager network;
  HomeRepository({required this.network});

  Future<void> getHomeItems(HomeItemsPayload payload, Function(Result result, HomeItemsData? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.getHomeItems, method: HTTPMethod.post, payload: NetworkPayload.homeItemPayload(payload: payload));
      try {
        final response = HomeItemsData.fromJson(networkResponse);
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

  Future<void> getCompanyDetails(HomeItemsPayload payload, Function(Result result, CompanyDetailsData? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.getCompanyDetails, method: HTTPMethod.post, payload: NetworkPayload.companyDetailsPayload(payload: payload));
      try {
        final response = CompanyDetailsData.fromJson(networkResponse);
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
