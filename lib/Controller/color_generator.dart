import 'dart:async';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:usak_seramik_app/Controller/extension.dart';

Future<PaletteGenerator> updatePaletteGenerator({required String url}) async {
  PaletteGenerator? paletteGenerator;
  paletteGenerator = await PaletteGenerator.fromImageProvider(
    NetworkImage(url),
    size: Size(400, 600),
    maximumColorCount: 5,
    timeout: 5.second(),
  );

  return paletteGenerator;
}
