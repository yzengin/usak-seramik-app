import 'package:flutter/material.dart';

Stopwatch stopwatch = Stopwatch();

void stopwatchTick(String filter) {
  stopwatch.reset();
  debugPrint('$filter: elapsed ${stopwatch.elapsedMilliseconds / 1000} sec');
}
