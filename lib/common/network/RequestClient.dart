import 'package:dio/dio.dart';
import 'package:flutter_application_1/common/network/RequestConfig.dart';

RequestClient requestClient = RequestClient();

class RequestClient {
  late Dio _dio;

  RequestClient() {
    _dio = Dio(
        BaseOptions(baseUrl: RequestConfig.baseUrl, connectTimeout: RequestConfig.connectTimeout)
    );
  }

  Future<dynamic> request(
      String url, {
      String method = "GET",
      Map<String, dynamic>? queryParameters,
      data,
      Map<String, dynamic>? headers
    }) async {
      Options options = Options()
        ..method = method
        ..headers = headers;

      Response response = await _dio.request(url,
          queryParameters: queryParameters, data: data, options: options);

      return response.data;
  }

  
}