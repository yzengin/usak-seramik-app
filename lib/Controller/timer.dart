import 'dart:async';

import 'package:flutter/material.dart';

typedef CountCallback = void Function(int value);

class AppTimer extends ValueNotifier<int> {
  int _counter = 0;
  Timer? _timer;
  bool countdowntimer;
  int countdowntime;
  VoidCallback? countdownCallback;
  CountCallback? callbackPerSecond;

  AppTimer({this.countdowntimer = false, this.countdowntime = 10, this.countdownCallback, this.callbackPerSecond}) : super(0) {
    if (countdowntimer) {
      _counter = countdowntime;
    }
  }

  int get counter => _counter;
  bool get isRunning => _timer != null;

  void _updateCounter(Timer timer) {
    try {
      if (countdowntimer) {
        if (_counter > 0) {
          if (_counter == 1) {
            countdownCallback?.call();
          }
          _counter--;
          if (callbackPerSecond != null) {
            callbackPerSecond?.call(counter);
          }
        } else {
          // reset();
        }
      } else {
        _counter++;
        if (callbackPerSecond != null) {
          callbackPerSecond?.call(counter);
        }
      }
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('_updateCounter() error $e');
    }
  }

  void start() {
    if (!isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), _updateCounter);
    }
  }

  void pause() {
    if (isRunning) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void reset() {
    if (countdowntimer) {
      _counter = countdowntime;
    } else {
      _counter = 0;
    }
    pause();
    notifyListeners();
  }
}
