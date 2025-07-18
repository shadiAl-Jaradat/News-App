/// This file defines constants used for API interactions in the application.
class ApiConstants {
  static const String baseUrl = 'https://gnews.io';
  static const String apiVersion = '/api/v4';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  static const String contentTypeHeader = 'Content-Type';
  static const String applicationJson = 'application/json';

  static const String apiKey = String.fromEnvironment('API_KEY', defaultValue: 'ea5b8995afc443e8171b71d88fa3daf5');

  // Endpoints
  static const String searchEndpoint = '/search';

  // Parameters
  static const String defaultLanguage = 'en';
  static const String defaultCountry = 'us';
  static const int maxArticles = 10;
}
