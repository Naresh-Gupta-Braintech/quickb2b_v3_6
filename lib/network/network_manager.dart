import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickb2b_v3_6/helper/routes_helper.dart';
import 'package:quickb2b_v3_6/network/custom_enums.dart';
import 'package:quickb2b_v3_6/network/network_end_point.dart';
import 'package:quickb2b_v3_6/network/network_exception.dart';
import 'package:quickb2b_v3_6/network/network_resources.dart';
import 'package:quickb2b_v3_6/utils/global_constant.dart';
import 'package:quickb2b_v3_6/utils/local_keys.dart';
import 'package:quickb2b_v3_6/utils/local_storage.dart';

class NetworkManager extends GetxService {
  final int _timeoutInSeconds = 30;
  Map<String, String> _requestCurl = {};
  final _baseURL = GlobalConstants.baseUrl;

  http.Client? _httpClient;

  http.Client get client {
    _httpClient ??= http.Client();
    return _httpClient!;
  }

  void cancelRequests() {
    _httpClient?.close();
    _httpClient = null;
  }

  void networkRequestCurlWith({String? token}) {
    _requestCurl = {'charset': 'UTF-8', 'Charset': 'utf-8', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    if (token != null) {
      _requestCurl.addAll({'Authorization': 'Bearer $token'});
    }

    final requestCurlTree = const JsonEncoder.withIndent('  ').convert(_requestCurl);
    debugConsole('Request curl :: $requestCurlTree');
  }

  Future<dynamic> loadHTTP({required Endpoints endpoint, String? slashedQuery, required HTTPMethod method, Map<String, dynamic>? payload, Map<String, dynamic>? queryParameters, Map<String, String>? multipartPayload, List<MultipartFiles>? multipartFiles}) async {
    final url = slashedQuery != null ? Uri.parse(_baseURL + endpointRawValues[endpoint]! + slashedQuery).replace(queryParameters: queryParameters) : Uri.parse(_baseURL + endpointRawValues[endpoint]!).replace(queryParameters: queryParameters);
    debugConsole('Request url :: $url');
    // debugConsole('Endpoint :: ${endpointRawValues[endpoint]!}');
    final bearerToken = await LocalStorage.getStringData(key: Keys.bearerToken);
    // debugConsole('Bearer token :: ${bearerToken ?? 'Not Authorized'}');
    // debugConsole('language Code:: ${languageCode ?? 'Not Selected fall to English'}');

    networkRequestCurlWith(token: bearerToken);

    final payloadTree = const JsonEncoder.withIndent('  ').convert(payload);
    if (payload != null) debugConsole('Payload :: $payloadTree');

    final multipartPayloadTree = const JsonEncoder.withIndent('  ').convert(multipartPayload);
    if (multipartPayload != null) debugConsole('Multipart Payload :: $multipartPayloadTree');

    dynamic jsonResponse;
    dynamic httpResponse;

    try {
      switch (method) {
        case (HTTPMethod.get):
          httpResponse = await client.get(url, headers: _requestCurl).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.post):
          httpResponse = await client.post(url, headers: _requestCurl, body: jsonEncode(payload)).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.put):
          httpResponse = await client.put(url, headers: _requestCurl, body: jsonEncode(payload)).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.delete):
          httpResponse = await client.delete(url, headers: _requestCurl, body: jsonEncode(payload)).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.patch):
          httpResponse = await client.patch(url, headers: _requestCurl, body: jsonEncode(payload)).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.multipartPUT):
          httpResponse = await httpMultipart(request: http.MultipartRequest('PUT', url), payload: multipartPayload, files: multipartFiles);
          break;
        case (HTTPMethod.multipartPOST):
          httpResponse = await httpMultipart(request: http.MultipartRequest('POST', url), payload: multipartPayload, files: multipartFiles);
          break;
      }
      jsonResponse = decodeHTTPResponseBody(httpResponse: httpResponse, endpoint: endpointRawValues[endpoint]!);
    } on SocketException {
      throw FetchNetworkException(exceptionRawValues[Exceptions.timedOutOrNoInternet]);
    }

    return jsonResponse;
  }

  Future<dynamic> httpMultipart({required http.MultipartRequest request, Map<String, String>? payload, List<MultipartFiles>? files}) async {
    request.headers.addAll(_requestCurl);
    for (MultipartFiles file0 in (files ?? [])) {
      if (file0.file != null) {
        File file = File(file0.file!.path);
        request.files.add(http.MultipartFile(file0.key, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
      }
    }
    if (payload != null) request.fields.addAll(payload);
    http.Response response = await http.Response.fromStream(await request.send()).timeout(Duration(seconds: _timeoutInSeconds));
    return response;
  }

  dynamic decodeHTTPResponseBody({required http.Response httpResponse, required String endpoint}) {
    debugConsole('Status code for $endpoint :: ${httpResponse.statusCode}');
    switch (httpResponse.statusCode) {
      case (201):
      case (200):
        // case (401):
        // case (403):
        try {
          final responseJson = json.decode(httpResponse.body.toString());
          final responseTree = const JsonEncoder.withIndent('  ').convert(responseJson);
          debugConsole('Response for $endpoint :: $responseTree');
          return responseJson;
        } catch (_) {
          throw FetchNetworkException(exceptionRawValues[Exceptions.unPreocessableResponse]);
        }
      case (400):
        print("Naresh :: in 400   ${json.decode(httpResponse.body.toString())}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.badRequest400]);
      case (401):
        throw FetchNetworkException(exceptionRawValues[Exceptions.unauthorized401]);
      case (403):
        throw FetchNetworkException(exceptionRawValues[Exceptions.forbidden403]);
      case (404):
        throw FetchNetworkException(exceptionRawValues[Exceptions.requestNotFound404]);
      case (405):
        throw FetchNetworkException(exceptionRawValues[Exceptions.methodNotAllowd405]);
      case (409):
        throw FetchNetworkException(exceptionRawValues[Exceptions.conflictInRequest409]);
      case (500):
        throw FetchNetworkException(exceptionRawValues[Exceptions.serverError500]);
      case (503):
        throw FetchNetworkException(exceptionRawValues[Exceptions.serviceUnavailable503]);
      default:
        throw FetchNetworkException(exceptionRawValues[Exceptions.unknownError000]);
    }
  }
}
