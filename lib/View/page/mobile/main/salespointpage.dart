import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/extension.dart';

class SalesPointsPage extends StatelessWidget {
  const SalesPointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AppBar(
            backgroundColor: context.theme.scaffoldBackgroundColor.withOpacity(0.75),
            title: Text(context.translete('stores')),
          ),
        ),
      ),
    ),body: Center(child: Text("Çok yakında..."),),
    );
  }
}