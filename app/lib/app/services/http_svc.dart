import 'dart:convert';

import 'package:detect_it/library/detect_it.dart';
import 'package:dio/dio.dart';

class HttpService {
  final dio = Dio();
  final timeOutRequest = AppConst.timeOutRequest;

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return json.decode(response.toString());
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<dynamic> post({
    required String url,
    dynamic data,
    String? dataString,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: data ?? dataString,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return json.decode(response.toString());
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
