import 'package:get/get.dart';
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/data/request/network_payloads.dart';
import 'package:quickb2b_v3_6/network/data/request/network_request_body.dart';
import 'package:quickb2b_v3_6/network/data/response/categories_model.dart';
import 'package:quickb2b_v3_6/network/data/response/product_model.dart';
import 'package:quickb2b_v3_6/network/network_end_point.dart';
import 'package:quickb2b_v3_6/network/network_exception.dart';
import 'package:quickb2b_v3_6/network/network_manager.dart';

class ProductRepository extends GetxController implements GetxService {
  NetworkManager network;
  ProductRepository({required this.network});

  Future<void> getAllCategories(CategoryPayload payload, Function(Result result, CategoriesModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.getCategories, method: HTTPMethod.post, payload: NetworkPayload.categoryPayload(payload: payload));
      try {
        final response = CategoriesModel.fromJson(networkResponse);
        print("Product Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, "");
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> searchProductByCategory(ProductPayload payload, Function(Result result, ProductModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.searchProductByCategory, method: HTTPMethod.post, payload: NetworkPayload.productPayload(payload: payload));
      try {
        final response = ProductModel.fromJson(networkResponse);
        print("Home Repository :: ${response.status}");
        completion((response.status == 1) ? Result.onSuccess : Result.onFailed, response, "");
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
