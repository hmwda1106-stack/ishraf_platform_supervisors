import 'package:connectivity_plus/connectivity_plus.dart';

/// Network Information Utility
/// Checks internet connectivity status
class NetworkInfo {
  final Connectivity _connectivity;
  
  NetworkInfo({Connectivity? connectivity}) 
      : _connectivity = connectivity ?? Connectivity();
  
  /// Check if device is connected to internet
  Future<bool> get isConnected async {
    try {
      final results = await _connectivity.checkConnectivity();
      return results.any((result) => 
        result != ConnectivityResult.none
      );
    } catch (e) {
      return false;
    }
  }
  
  /// Get current connectivity type
  Future<ConnectivityResult> get connectivityType async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (results.contains(ConnectivityResult.wifi)) {
        return ConnectivityResult.wifi;
      } else if (results.contains(ConnectivityResult.mobile)) {
        return ConnectivityResult.mobile;
      } else if (results.contains(ConnectivityResult.ethernet)) {
        return ConnectivityResult.ethernet;
      } else if (results.contains(ConnectivityResult.bluetooth)) {
        return ConnectivityResult.bluetooth;
      }
      return ConnectivityResult.none;
    } catch (e) {
      return ConnectivityResult.none;
    }
  }
  
  /// Stream of connectivity changes
  Stream<ConnectivityResult> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((results) {
      if (results.contains(ConnectivityResult.wifi)) {
        return ConnectivityResult.wifi;
      } else if (results.contains(ConnectivityResult.mobile)) {
        return ConnectivityResult.mobile;
      } else if (results.contains(ConnectivityResult.ethernet)) {
        return ConnectivityResult.ethernet;
      } else if (results.contains(ConnectivityResult.bluetooth)) {
        return ConnectivityResult.bluetooth;
      }
      return ConnectivityResult.none;
    });
  }
}
