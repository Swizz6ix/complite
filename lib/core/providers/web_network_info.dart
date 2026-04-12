import 'package:complite/core/providers/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class WebNetworkInfo implements NetworkInfo {
  final Connectivity _connectivity;

  WebNetworkInfo(this._connectivity);

  static const _urls = [
    'https://jsonplaceholder.typicode.com/posts/1',
    'https://api.github.com',
  ];

  @override
  Future<bool> get isConnected async {
    final connectivity = await _connectivity.checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      return false;
    }

    return await _httpCheck();
  }

  Future<bool> _httpCheck() async {
    for (final url in _urls) {
      try {
        final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 5));

        if (response.statusCode >= 200 && response.statusCode < 500) {
          return true;
        }
      } catch (_) {}
    }
    return false;
  }
}