import 'package:dio/dio.dart';

import '../errors/exceptions.error.dart';
import '../errors/status_code.error.dart';

class DioClient {
  DioClient({required this.baseUrl}) {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 50);
    _dio.options.receiveTimeout = const Duration(seconds: 50);
  }

  late final Dio _dio;
  final String baseUrl;

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);

      return response.data;
    } on DioException catch (e) {
      throw _dioError(exception: e, uri: path);
    }
  }

  Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);

      return response.data;
    } on DioException catch (e) {
      throw _dioError(exception: e, uri: path);
    }
  }

  Future put({required String path, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(path, data: data);

      return response.data;
    } on DioException catch (e) {
      throw _dioError(exception: e, uri: path);
    }
  }

  Future delete({required String path}) async {
    try {
      final response = await _dio.delete(path);

      return response.data;
    } on DioException catch (e) {
      throw _dioError(exception: e, uri: path);
    }
  }

  HttpExceptionService _dioError({
    required DioException exception,
    required String uri,
  }) {
    if ((exception.type == DioExceptionType.connectionTimeout) ||
        (exception.type == DioExceptionType.receiveTimeout)) {
      return const TimeOutException(message: 'TimeOutException');
    } else if ((exception.type == DioExceptionType.badResponse) &&
        (exception.response?.statusCode != null)) {
      return StatusCode.typeStatusCode(
        statusCode: exception.response!.statusCode!,
      );
    }
    return const UnexpectedError(message: 'UnexpectedError');
  }
}
