import 'package:flutter/material.dart';

class AppInputDecoration {
  static InputBorder enabledBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    // borderSide: BorderSide(color: AppColors.orange.withOpacity(.5), width: 1),
    borderSide: BorderSide(color: Colors.black.withOpacity(.5), width: 1),
  );

  static InputBorder focusedBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: Colors.black, width: 3),
  );
}
