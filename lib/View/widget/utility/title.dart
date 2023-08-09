// ignore_for_file: unnecessary_string_interpolations
import 'dart:ui';
import 'package:flutter/material.dart';

class AppTitle extends StatefulWidget {
  const AppTitle(this.title, {super.key, this.primaryColor = Colors.purpleAccent, this.secondaryColor = Colors.pinkAccent});
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  State<AppTitle> createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700), reverseDuration: const Duration(milliseconds: 700), value: 0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    controller.forward();
     final Animation<Offset> offsetAnimation = Tween<Offset>(
        begin: const Offset(-3, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCirc,
        reverseCurve: Curves.easeInCirc,
      ));
      
    return AnimatedBuilder(
        animation: controller,
        builder: (context, a) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Stack(
              children: [
                SlideTransition(
                  position: offsetAnimation,
                  child: Transform(
                    transform: Matrix4.diagonal3Values(lerpDouble(1.4, 1, controller.value)!, lerpDouble(1.1, 1, controller.value)!, 1),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: widget.secondaryColor, borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${widget.title}",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: widget.secondaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                SlideTransition(
                  position: offsetAnimation,
                  child: Transform(
                    transform: Matrix4.diagonal3Values(lerpDouble(1.3, 1, controller.value)!, 1, 1),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: widget.primaryColor, borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${widget.title}",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: widget.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "${widget.title}",
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}

