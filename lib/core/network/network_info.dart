import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract class to check network connectivity status.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] that uses the [Connectivity] package
/// to determine if the device is connected to the internet.
/// must inject [Connectivity] instance to the constructor.
/// This class provides a [isConnected] method to check the connectivity status
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    // return true;
    final result = await connectivity.checkConnectivity();
    return result.any((connection) => connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi);
  }
}
