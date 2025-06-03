import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'dio_logger_interceptor.dart';

typedef ProgressListener = void Function(int total, int progress, int percent);

class CustomInterceptorsWrapper extends InterceptorsWrapper {
  Duration timeOut;
  CustomInterceptorsWrapper({this.timeOut = const Duration(seconds: 30000)});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // String? token = await AppPreferences.getToken();
    var customHeaders = {
      // định dạng truyền param lên là gì loại gì
      Headers.acceptHeader: "*/*",
      Headers.contentTypeHeader: Headers.jsonContentType,
      // HttpHeaders.authorizationHeader: token
    };
    options.baseUrl = "https://dev.scigroup.com.vn/";
    options.responseType = ResponseType.json;
    options.connectTimeout = timeOut;
    options.receiveTimeout = timeOut;
    options.sendTimeout = timeOut;
    options.headers.addAll(customHeaders);

    super.onRequest(options, handler);
  }
}

class RestClient {
  late Dio _dio;

  static final RestClient _instance = RestClient();

  static RestClient get instance {
    return _instance;
  }

  RestClient() {
    _dio = Dio();

    if (!kIsWeb) {
      // chưa hiểu hàm này dùng để làm gì
      _dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      });
    }

    _dio.interceptors.add(CustomInterceptorsWrapper());

    // _dio.interceptors.add(CurlLoggerDioInterceptor(
    //   convertFormData: true,   // Nếu dùng FormData, sẽ log ra body rõ ràng
    //   printOnSuccess: true,    // Log cả request thành công
    //   // printOnError: true,      // Log cả request bị lỗi
    // ));
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
        ),
      );
    }
  }

  Future<Response> downloadFile(
    String path,
  ) async {
    try {
      final response = await Dio().get(
        path,
        options: Options(responseType: ResponseType.bytes),
      );
      return response;
    } on DioException {
      rethrow;
    } on Exception {
      rethrow;
    } finally {}
  }

  Future<dynamic> post(String path, Map<String, dynamic> params) async {
    try {
      // var param = FormData.fromMap(params);
      Response response = await _dio.post(path, data: params);
      return response;
    } on DioException {
      rethrow;
    } on Exception {
      rethrow;
    } finally {}
  }

  Future<dynamic> postJson(String path, Map<String, dynamic> params) async {
    try {
      final data = jsonEncode(params);
      print('RestClient.postJson');
      print(data);
      Response response = await _dio.post(path, data: data);
      return response;
    } on DioException {
      rethrow;
    } on Exception {
      rethrow;
    } finally {}
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    try {
      Response response = await _dio.get(path, queryParameters: params);
      return response;
    } on DioException {
      rethrow;
    } on Exception {
      rethrow;
    } finally {}
  }
}
