import 'package:flutter/material.dart';

Route appRouteBuilder(
  BuildContext context,
  Widget routePage, {
  Color? barrierColor,
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) {
  return PageRouteBuilder(
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    reverseTransitionDuration: reverseTransitionDuration ?? const Duration(milliseconds: 300),
    barrierColor: barrierColor ?? Colors.black,
    barrierDismissible: false,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
      return routePage;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
      // return FadeTransition(
      //   opacity: animation,
      //   child: child,
      // );
      // ---------------------------------------------------------------------------------------------------

      // return ScaleTransition(
      //   scale: animation,
      //   alignment: Alignment.bottomCenter,
      //   child: child,
      // );
      // ---------------------------------------------------------------------------------------------------

      // return RotationTransition(
      //   turns: animation,
      //   child: child,
      // );
      // ---------------------------------------------------------------------------------------------------

      // final Animation<Offset> offsetAnimation = Tween<Offset>(
      //   begin: const Offset(0, -1),
      //   end: Offset.zero,
      // ).animate(CurvedAnimation(
      //   parent: animation,
      //   curve: Curves.easeOutCirc,
      //   reverseCurve: Curves.easeInCirc,
      // ));
      // return SlideTransition(
      //   position: offsetAnimation,
      //   child: child,
      // );
      // ---------------------------------------------------------------------------------------------------

      // final Animation<Offset> offsetAnimation = Tween<Offset>(
      //   begin: const Offset(0.25, 0),
      //   end: Offset.zero,
      // ).animate(CurvedAnimation(
      //   parent: animation,
      //   curve: Curves.easeOutCirc,
      //   reverseCurve: Curves.easeInCirc,
      // ));
      // return FadeTransition(
      //   opacity: animation,
      //   child: SlideTransition(
      //     position: offsetAnimation,
      //     child: child,
      //   ),
      // );
      // ---------------------------------------------------------------------------------------------------

      return child;
    },
  );
}
