import 'dart:async';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import '/Controller/extension.dart';

Future<PaletteGenerator> updatePaletteGenerator({required String url, Size? downScale}) async {
  PaletteGenerator paletteGenerator;
  paletteGenerator = await PaletteGenerator.fromImageProvider(
    NetworkImage(url),
    size: downScale ?? const Size(400, 600),
    maximumColorCount: 5,
    timeout: 5.second(),
  );

  return paletteGenerator;
}
