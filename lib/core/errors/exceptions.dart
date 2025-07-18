/// Exception classes for handling technical errors (infrastructure level)
class ServerException implements Exception {
  final String message;

  const ServerException({this.message = 'Server error occurred'});
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({this.message = 'Network error occurred'});
}
