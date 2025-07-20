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

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, error: true));

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) => handler.reject(DioException(requestOptions: error.requestOptions, error: _handleError(error))),
      ),
    );
  }

  /// Requests

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  /// Error Handling

  Exception _handleError(DioException error) {
    // Extract error message from GNews API response
    String errorMessage = _getGNewsErrorMessage(error);

    DioExceptionType type = error.type;
    return switch (type) {
      DioExceptionType.connectionTimeout => NetworkException(message: 'Connection timeout'),
      DioExceptionType.receiveTimeout => NetworkException(message: 'Server timeout'),
      DioExceptionType.badResponse => ServerException(message: errorMessage),
      DioExceptionType.cancel => NetworkException(message: 'Request cancelled'),
      DioExceptionType.connectionError => NetworkException(message: 'No internet connection'),
      DioExceptionType.unknown => NetworkException(message: 'Network error'),
      _ => ServerException(message: 'Server error'),
    };
  }

  String _getGNewsErrorMessage(DioException error) {
    try {
      final data = error.response?.data;
      if (data != null && data is Map<String, dynamic> && data['errors'] != null) {
        if (data['errors'] is List) {
          final List errors = data['errors'];
          if (errors.isNotEmpty) {
            return errors.first.toString();
          }
        }

        if (data['errors'] is Map) {
          final Map<String, dynamic> errors = data['errors'];
          if (errors.isNotEmpty) {
            return errors.values.first.toString();
          }
        }
      }
    } catch (e) {
      // If parsing fails, use status code messages
    }

    // Fallback to GNews status code messages
    final statusCode = error.response?.statusCode;
    return switch (statusCode) {
      400 => 'Your request is invalid',
      401 => 'Your API key is wrong',
      403 => 'You have reached your daily quota',
      429 => 'Too many requests per second',
      500 => 'Server problem. Try again later',
      503 => 'Service temporarily offline for maintenance',
      _ => 'Server error occurred',
    };
  }
}
