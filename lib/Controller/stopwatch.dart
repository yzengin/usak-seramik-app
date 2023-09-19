import 'package:flutter/material.dart';

Stopwatch stopwatch = Stopwatch();

void stopwatchTick(String filter) {
  debugPrint('$filter: elapsed ${stopwatch.elapsedMilliseconds / 1000} sec');
  stopwatch.reset();
}
