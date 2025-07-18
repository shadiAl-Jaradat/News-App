import 'package:dio/dio.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/core/errors/exceptions.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: '${ApiConstants.baseUrl}${ApiConstants.apiVersion}',
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {ApiConstants.contentTypeHeader: ApiConstants.applicationJson},
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) => throw _handleError(error)));
  }

  /// Requests

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Error Handling

  Exception _handleError(DioException error) {
    DioExceptionType type = error.type;
    return switch (type) {
      DioExceptionType.connectionTimeout => NetworkException(message: 'Connection timeout'),
      DioExceptionType.receiveTimeout => NetworkException(message: 'Receive timeout'),
      DioExceptionType.badResponse => ServerException(message: 'Server error: ${error.response?.statusCode}'),
      DioExceptionType.cancel => NetworkException(message: 'Request cancelled'),
      DioExceptionType.unknown => NetworkException(message: 'Network error occurred'),
      _ => ServerException(message: 'Unexpected error occurred'),
    };
  }
}
