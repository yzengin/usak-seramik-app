import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/Controller/extension.dart';

// ignore: must_be_immutable
class AppBottomSheet extends StatefulWidget {
  AppBottomSheet({
    super.key,
    this.maxSize = 0.5,
    this.initialSize = 0.1,
    this.child,
    this.title,
  });
  double maxSize;
  double initialSize;
  Widget? child;
  String? title;
  

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> with SingleTickerProviderStateMixin {
  double? minSize;
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, lowerBound: 0, upperBound: widget.initialSize, duration: 300.millisecond(), reverseDuration: 300.millisecond());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    minSize = minSize != null ? minSize : widget.initialSize;
    ValueNotifier<double> currentSheetPosition = ValueNotifier<double>(0);

    return SizedBox(
      width: context.width,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return DraggableScrollableSheet(
              maxChildSize: widget.maxSize,
              minChildSize: animationController.value,
              initialChildSize: animationController.value,
              controller: draggableScrollableController,
              snap: true,
              expand: false,
              snapAnimationDuration: 250.millisecond(),
              snapSizes: [widget.initialSize, widget.maxSize],
              builder: (context, scrollController) {
                return NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    currentSheetPosition.value = notification.extent.reduceRange(widget.maxSize, minSize!);
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (currentSheetPosition.value == 0) {
                              draggableScrollableController.animateTo(1, duration: 300.millisecond(), curve: Curves.ease);
                            } else {
                              draggableScrollableController.animateTo(0, duration: 300.millisecond(), curve: Curves.ease);
                            }
                          },
                          child: Container(
                              height: context.height * widget.initialSize,
                              width: context.width,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Opacity(opacity: 0, child: Icon(FontAwesomeIcons.chevronUp)),
                                    Text(widget.title ?? ""),
                                    ValueListenableBuilder(
                                        valueListenable: currentSheetPosition,
                                        builder: (context, _, __) {
                                          return Transform.rotate(angle: pi * -currentSheetPosition.value, child: Icon(FontAwesomeIcons.chevronUp));
                                        }),
                                  ],
                                ),
                              )),
                        ),
                        widget.child ?? const SizedBox(),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
