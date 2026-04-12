import 'package:complite/core/providers/mobile_network_info.dart';
import 'package:complite/core/providers/network_info.dart';
import 'package:complite/core/providers/web_network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkProvider = Provider<NetworkInfo>((ref) {
  final connectivity = Connectivity();
  print("before web check");
  if (kIsWeb) {
    print("web check");
    return WebNetworkInfo(connectivity);
  }

  return MobileNetworkInfo(Connectivity());
});