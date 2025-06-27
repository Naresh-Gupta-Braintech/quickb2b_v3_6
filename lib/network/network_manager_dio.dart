// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:quickb2b_v3_6/helper/routes_helper.dart';
// import 'package:quickb2b_v3_6/network/custom_enums.dart';
// import 'package:quickb2b_v3_6/network/network_end_point.dart';
// import 'package:quickb2b_v3_6/network/network_resources.dart';
// import 'package:quickb2b_v3_6/utils/global_constant.dart';
// import 'package:quickb2b_v3_6/utils/local_keys.dart';
// import 'package:quickb2b_v3_6/utils/local_storage.dart';

// class NetworkManagerDio extends GetxService {
//   Dio? _dio;
//   Map<String, String> _requestCurl = {};
//   final _baseURL = GlobalConstant.baseUrl;
//   Options options = Options(contentType: 'application/json', receiveDataWhenStatusError: true, sendTimeout: Duration(seconds: 10), receiveTimeout: Duration(seconds: 30));

//   Dio get dioClient {
//     _dio ??= Dio();
//     return _dio!;
//   }

//   void networkRequestCurlWith({String? token}) {
//     _requestCurl = {'charset': 'UTF-8', 'Charset': 'utf-8', 'Accept': 'application/json', 'Content-Type': 'application/json'};
//     if (token != null) {
//       _requestCurl.addAll({'Authorization': 'Bearer $token'});
//     }
//     options.headers = _requestCurl;
//     final requestCurlTree = const JsonEncoder.withIndent('  ').convert(_requestCurl);
//     debugConsole('Request curl :: $requestCurlTree');
//     // dioClient.interceptors.add(
//     //   InterceptorsWrapper(
//     //     onRequest: (options, handler) {
//     //       return handler.next(options);
//     //     },
//     //     onResponse: (response, handler) {
//     //       return handler.next(response);
//     //     },

//     //     onError: (error, handler) {
//     //       return handler.next(error);
//     //     },
//     //   ),
//     // );
//   }

//   Future<dynamic> loadHTTP({String? languageCode, required Endpoints endpoint, String? slashedQuery, required HTTPMethod method, Map<String, dynamic>? payload, Map<String, dynamic>? queryParameters, Map<String, String>? multipartPayload, List<MultipartFiles>? multipartFiles}) async {
//     final url = slashedQuery != null ? Uri.parse(_baseURL + endpointRawValues[endpoint]! + slashedQuery).replace(queryParameters: queryParameters) : Uri.parse(_baseURL + endpointRawValues[endpoint]!).replace(queryParameters: queryParameters);
//     debugConsole('Request url :: $url');
//     // debugConsole('Endpoint :: ${endpointRawValues[endpoint]!}');
//     final bearerToken = await LocalStorage.getStringData(key: Keys.bearerToken);

//     networkRequestCurlWith(token: bearerToken);

//     final payloadTree = const JsonEncoder.withIndent('  ').convert(payload);
//     if (payload != null) debugConsole('Payload :: $payloadTree');

//     final multipartPayloadTree = const JsonEncoder.withIndent('  ').convert(multipartPayload);
//     if (multipartPayload != null) debugConsole('Multipart Payload :: $multipartPayloadTree');

//     dynamic jsonResponse;
//     dynamic httpResponse;

//     try {
//       switch (method) {
//         case (HTTPMethod.get):
//           httpResponse = await dioClient.get(url.toString(), options: options);
//           break;
//         case (HTTPMethod.post):
//           httpResponse = await dioClient.post(url.toString(), options: options, data: jsonEncode(payload));
//           break;
//         case (HTTPMethod.put):
//           httpResponse = await dioClient.put(url.toString(), options: options, data: jsonEncode(payload));
//           break;
//         case (HTTPMethod.delete):
//           httpResponse = await dioClient.delete(url.toString(), options: options, data: jsonEncode(payload));
//           break;
//         case (HTTPMethod.patch):
//           httpResponse = await dioClient.patch(url.toString(), options: options, data: jsonEncode(payload));
//           break;
//         case (HTTPMethod.multipartPUT):
//           httpResponse = await httpMultipart(request: http.MultipartRequest('PUT', url), payload: multipartPayload, files: multipartFiles);
//           break;
//         case (HTTPMethod.multipartPOST):
//           httpResponse = await httpMultipart(request: http.MultipartRequest('POST', url), payload: multipartPayload, files: multipartFiles);
//           break;
  
//       }
//       // jsonResponse = decodeHTTPResponseBody(httpResponse: httpResponse, endpoint: endpointRawValues[endpoint]!);
//     } on SocketException {
//       // throw FetchNetworkException(exceptionRawValues[Exceptions.timedOutOrNoInternet]);
//     }

//     return jsonResponse;
//   }

//   Future<dynamic> httpMultipart({required String url,required Object data, List<MultipartFiles>? files}) async {

//   }
// }
