import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../Controller/asset.dart';
import '../../../Controller/extension.dart';

Future appSpinner(BuildContext context, {Widget? navigate, String routeName = 'appProcessDialog'}) {
  Color primary = const Color.fromARGB(255, 58, 56, 181);
  return showDialog(
    context: context,
    routeSettings: RouteSettings(name: routeName),
    barrierColor: primary.withOpacity(.5),
    builder: (context) {
      if (navigate != null) {
        Future.delayed(const Duration(milliseconds: 2000), () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => navigate), (route) => false));
      }
      return WillPopScope(
        onWillPop: () async => true,
        child: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox.square(
              dimension: context.width * 0.4,
              child: Center(
                child: Dialog(
                  backgroundColor: const Color.fromARGB(0, 249, 192, 230),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.width)),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  alignment: Alignment.center,
                  elevation: 0,
                  shadowColor: Colors.black,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Center(child: Lottie.asset(AppAnimation.loading)),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
