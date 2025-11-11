import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' as gt;
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/network_end_point.dart';
import 'package:quickb2b_v3_6/network/network_exception.dart';
import 'package:quickb2b_v3_6/network/network_resources.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

class NetworkManager extends gt.GetxService {
  final int _timeoutInSeconds = 30;
  final _baseURL = GlobalConstants.baseUrl;
  late dio.Dio _dio;
  Map<String, String> _requestCurl = {};

  NetworkManager() {
    _dio = dio.Dio(
      dio.BaseOptions(
        baseUrl: _baseURL,
        connectTimeout: Duration(seconds: _timeoutInSeconds),
        receiveTimeout: Duration(seconds: _timeoutInSeconds),
        headers: {'charset': 'UTF-8', 'Charset': 'utf-8', 'Accept': 'application/json', 'Content-Type': 'application/json'},
      ),
    );
  }

  void cancelRequests() {
    _dio.close(force: true);
    _dio = dio.Dio(_dio.options);
  }

  void networkRequestCurlWith({String? token}) {
    _requestCurl = {'charset': 'UTF-8', 'Charset': 'utf-8', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    if (token != null) {
      _requestCurl['Authorization'] = 'Bearer $token';
    }
    _dio.options.headers = _requestCurl;

    final requestCurlTree = const JsonEncoder.withIndent('  ').convert(_requestCurl);
    debugConsole('Request curl :: $requestCurlTree');
  }

  Future<dynamic> loadHTTP({
    required Endpoints endpoint,
    String? slashedQuery,
    required HTTPMethod method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? multipartPayload,
    List<MultipartFiles>? multipartFiles,
  }) async {
    final bearerToken = await LocalStorage.getStringData(key: Keys.bearerToken);
    networkRequestCurlWith(token: bearerToken);

    final endpointPath = endpointRawValues[endpoint]!;
    final url = slashedQuery != null ? endpointPath + slashedQuery : endpointPath;
    debugConsole("complete url :: $url");

    if (payload != null) {
      final payloadTree = const JsonEncoder.withIndent('  ').convert(payload);
      debugConsole('Payload :: $payloadTree');
    }

    if (multipartPayload != null) {
      final multipartPayloadTree = const JsonEncoder.withIndent('  ').convert(multipartPayload);
      debugConsole('Multipart Payload :: $multipartPayloadTree');
    }

    try {
      dio.Response response;
      switch (method) {
        case HTTPMethod.get:
          response = await _dio.get(url, queryParameters: queryParameters);
          break;
        case HTTPMethod.post:
          response = await _dio.post(url, data: payload, queryParameters: queryParameters);
          break;
        case HTTPMethod.put:
          response = await _dio.put(url, data: payload, queryParameters: queryParameters);
          break;
        case HTTPMethod.delete:
          response = await _dio.delete(url, data: payload, queryParameters: queryParameters);
          break;
        case HTTPMethod.patch:
          response = await _dio.patch(url, data: payload, queryParameters: queryParameters);
          break;
        case HTTPMethod.multipartPUT:
        case HTTPMethod.multipartPOST:
          response = await httpMultipart(url: url, method: method, payload: multipartPayload, files: multipartFiles);
          break;
      }
      return decodeHTTPResponseBody(httpResponse: response, endpoint: endpointPath);
    } on dio.DioException catch (e) {
      if (e.type == dio.DioExceptionType.connectionTimeout || e.type == dio.DioExceptionType.receiveTimeout) {
        throw FetchNetworkException(exceptionRawValues[Exceptions.timedOutOrNoInternet]);
      }
      if (e.response != null) {
        return decodeHTTPResponseBody(httpResponse: e.response!, endpoint: url);
      }
      throw FetchNetworkException(exceptionRawValues[Exceptions.unknownError000]);
    }
  }

  Future<dio.Response> httpMultipart({required String url, required HTTPMethod method, Map<String, String>? payload, List<MultipartFiles>? files}) async {
    final formData = dio.FormData();

    if (payload != null) {
      payload.forEach((key, value) => formData.fields.add(MapEntry(key, value)));
    }

    if (files != null) {
      for (var file in files) {
        if (file.file != null) {
          final fileName = file.file!.path.split('/').last;
          formData.files.add(MapEntry(file.key, await dio.MultipartFile.fromFile(file.file!.path, filename: fileName)));
        }
      }
    }

    return await _dio.request(url, data: formData, options: dio.Options(method: method == HTTPMethod.multipartPUT ? 'PUT' : 'POST', contentType: 'multipart/form-data'));
  }

  dynamic decodeHTTPResponseBody({required dio.Response httpResponse, required String endpoint}) {
    debugConsole('Status code for $endpoint :: ${httpResponse.statusCode}');
    switch (httpResponse.statusCode) {
      case 200:
      case 201:
        try {
          final responseTree = const JsonEncoder.withIndent('  ').convert(httpResponse.data);
          debugConsole('Response for $endpoint :: $responseTree');
          return httpResponse.data;
        } catch (_) {
          throw FetchNetworkException(exceptionRawValues[Exceptions.unPreocessableResponse]);
        }
      case 400:
        debugConsole("Naresh :: in 400   ${httpResponse.data}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.badRequest400]);
      case 401:
        throw FetchNetworkException(exceptionRawValues[Exceptions.unauthorized401]);
      case 403:
        throw FetchNetworkException(exceptionRawValues[Exceptions.forbidden403]);
      case 404:
        throw FetchNetworkException(exceptionRawValues[Exceptions.requestNotFound404]);
      case 405:
        throw FetchNetworkException(exceptionRawValues[Exceptions.methodNotAllowd405]);
      case 409:
        throw FetchNetworkException(exceptionRawValues[Exceptions.conflictInRequest409]);
      case 500:
        throw FetchNetworkException(exceptionRawValues[Exceptions.serverError500]);
      case 503:
        throw FetchNetworkException(exceptionRawValues[Exceptions.serviceUnavailable503]);
      default:
        throw FetchNetworkException(exceptionRawValues[Exceptions.unknownError000]);
    }
  }
}
