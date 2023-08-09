import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<PaletteGenerator> updatePaletteGenerator({ImageProvider? image, Rect? newRegion}) async {
  PaletteGenerator? paletteGenerator;
  if (image == null) {
    paletteGenerator = PaletteGenerator.fromColors([PaletteColor(Colors.black, 10)]);
  } else {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      image,
      size: newRegion?.size ?? const Size(400, 600),
      region: newRegion,
      maximumColorCount: 20,
    );
  }
  return paletteGenerator;
}
