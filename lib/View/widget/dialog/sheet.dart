import 'package:flutter/material.dart';

Future<void> appSheet(
  BuildContext context, {
  Color? barrierColor,
  Color? backgroundColor,
  Widget? child,
  Duration delay = const Duration(milliseconds: 750),
  bool onWillPop = true,
  double blur = 2,
  VoidCallback? rewindCallback,
  String routeName = 'appSheet',
  double initialSize = 0.25,
  double maxSize = 0.75,
}) async {
  showModalBottomSheet(
    context: context,
    routeSettings: RouteSettings(name: routeName),
    enableDrag: true,
    elevation: 100,
    isDismissible: onWillPop,
    isScrollControlled: true,
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(0)),
    barrierColor: barrierColor != null ? barrierColor.withOpacity(.5) : Theme.of(context).colorScheme.secondary.withOpacity(.5),
    backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
    builder: (context) {
      DraggableScrollableController draggableScrollableController = DraggableScrollableController();
      // Future.delayed(rewindCallback != null ? const Duration(milliseconds: 2000) : delay, () => Navigator.pop(context));
      return DraggableScrollableSheet(
          controller: draggableScrollableController,
          initialChildSize: initialSize, //set this as you want
          maxChildSize: maxSize, //set this as you want
          minChildSize: 0, //set this as you want
          expand: false,
          snap: true,
          snapSizes: [initialSize, maxSize],
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              physics: NeverScrollableScrollPhysics(),
              child: Padding(padding: const EdgeInsets.all(20.0), child: child ?? SizedBox()),
            );
          });
    },
  );
}
