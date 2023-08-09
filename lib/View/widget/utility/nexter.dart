// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators
import 'package:flutter/material.dart';
import '../../../Controller/extension.dart';

class Nexter extends StatelessWidget {
  const Nexter({
    super.key,
    required this.value,
    this.increaseCallback,
    this.decreaseCallback,
    this.increaseChild,
    this.decreaseChild,
    this.innerDecoration,
    this.outherDecoration,
    this.size,
  });
  final Object value;
  final VoidCallback? increaseCallback;
  final VoidCallback? decreaseCallback;
  final Widget? increaseChild;
  final Widget? decreaseChild;
  final BoxDecoration? innerDecoration;
  final BoxDecoration? outherDecoration;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size != null
          ? size!.width != double.infinity
              ? size!.width
              : context.width * 0.5
          : context.width * 0.5,
      height: size != null
          ? size!.height != double.infinity
              ? size!.height
              : kToolbarHeight
          : kToolbarHeight,
      child: DecoratedBox(
        decoration: outherDecoration ?? const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    if (decreaseCallback != null) {
                      decreaseCallback!.call();
                    }
                  },
                  child: DecoratedBox(
                      decoration: innerDecoration ?? const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: decreaseChild ?? const Icon(Icons.exposure_minus_1_outlined),
                      ))),
              Expanded(child: Center(child: Text(value.toString()))),
              GestureDetector(
                  onTap: () {
                    if (increaseCallback != null) {
                      increaseCallback!.call();
                    }
                  },
                  child: DecoratedBox(
                      decoration: innerDecoration ?? const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: increaseChild ?? const Icon(Icons.exposure_plus_1_outlined),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
