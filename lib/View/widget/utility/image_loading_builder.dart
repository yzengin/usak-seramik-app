import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../style/colors.dart';
import '../../../Controller/extension.dart';

Widget loadingBuilder(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress != null) {
    double? loadRate = loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!;
    return Stack(
      children: [
        // Opacity(
        //   opacity: loadRate,
        //   child: Center(child: Icon(FontAwesomeIcons.solidFile, size: context.width * 0.3, color: AppColors.primaryColor)),
        // ),
        Center(child: CircularProgressIndicator(value: loadRate, color: AppColors.primaryColor))
      ],
    );
  } else {
    return child;
  }
}

Widget errorBuilder(BuildContext context, Object error, StackTrace? stackTrace) {
  return Center(child: Icon(FontAwesomeIcons.fileCircleExclamation, size: context.width * 0.3, color: AppColors.primaryColor));
}
