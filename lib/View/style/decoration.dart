import 'package:flutter/material.dart';
import '/view/style/colors.dart';

class AppDecorations {
  static BoxDecoration doodleDecoration() => const BoxDecoration(color: Colors.white);
  static BoxDecoration textFieldDecoration() => BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.primaryColor, width: 3));
}
