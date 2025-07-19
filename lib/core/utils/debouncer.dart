import 'dart:async';
import 'package:flutter/animation.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(seconds: 500)});

  void call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void cancel() => _timer?.cancel();

  void dispose() => _timer?.cancel();
}
