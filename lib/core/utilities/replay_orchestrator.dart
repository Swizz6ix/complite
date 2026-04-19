import 'dart:async';

import 'package:complite/core/providers/network_info.dart';
import 'package:complite/core/utilities/replay_engine.dart';

class ReplayOrchestrator {
  final ReplayEngine _engine;
  final NetworkInfo _network;

  StreamSubscription? _sub;

  ReplayOrchestrator(this._engine, this._network);

  void start() {
    _sub = _network.onStatusChange
      .distinct()
      .listen((isConnected) {
      if (isConnected) {
        _engine.replay();
      }
    });
  }

  void dispose() {
    _sub?.cancel();
  }
}