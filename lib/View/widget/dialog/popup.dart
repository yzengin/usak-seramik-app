import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/Controller/extension.dart';

Future<void> appModalPopup(
  BuildContext context,
  String title, {
  Color backgroundColor = Colors.black,
  Color? barrierColor,
  Widget? action,
  Duration delay = const Duration(milliseconds: 750),
  bool onWillPop = false,
  double blur = 3,
  VoidCallback? rewindCallback,
  String routeName = 'appModalPopup',
}) async {
  barrierColor = barrierColor ?? Colors.transparent;
  showCupertinoModalPopup(
    context: context,
    routeSettings: RouteSettings(name: routeName),
    barrierDismissible: onWillPop,
    // filter: ImageFilter.compose(outer: ImageFilter.blur(sigmaX: blur, sigmaY: blur), inner: ColorFilter.mode(barrierColor, BlendMode.multiply)),
    filter: ColorFilter.mode(Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.75), BlendMode.srcOver),
    barrierColor: barrierColor,
    builder: (context) {
      Future.delayed(rewindCallback != null ? 2.second() : delay, () => Navigator.pop(context));
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: backgroundColor,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14))),
                  if (action != null) action,
                  if (rewindCallback != null) GestureDetector(onTap: rewindCallback.call, child: const Text('Geri Al', style: TextStyle(color: Colors.blueAccent))),
                ],
              )),
        ),
      );
    },
  );
}
