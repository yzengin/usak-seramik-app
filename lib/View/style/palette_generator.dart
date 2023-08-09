import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<PaletteGenerator?> generatePalette(String imageUrl) async {
  PaletteGenerator? paletteGenerator;
  try {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),
      size: const Size(100, 100),
    );
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
  return paletteGenerator;
}
