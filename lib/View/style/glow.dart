import 'package:flutter/material.dart';

class WithoutGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}

// USAGE
// ScrollConfiguration(
//   behavior: WithoutGlow(),
//   child: const SizedBox()
// ),