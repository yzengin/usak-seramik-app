import 'package:flutter/material.dart';

class PainterAnimation extends CustomPainter {
  PainterAnimation(this.animation) : super(repaint: animation) {
    curve = CurvedAnimation(
      parent: animation,
      curve: Curves.ease,
    );
  }
  late Animation<double> animation;
  late Animation curve;

  Paint brush = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    layer1(canvas, width, height);
  }

  void layer1(Canvas canvas, double width, double height) {
    Path path = Path()..moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.close();
    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Painter extends CustomPainter {
  Painter();

  Paint brush = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    layer1(canvas, width, height);
  }

  void layer1(Canvas canvas, double width, double height) {
    Path path = Path()..moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.close();
    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
