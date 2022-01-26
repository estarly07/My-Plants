import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.15,
        size.width * 0.75, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.15,
        size.width * 0.55, size.height * 0.1);
    path.quadraticBezierTo(
        size.width * 0.3, 0, size.width * 0.15, size.height * 0.05);
    path.quadraticBezierTo(size.width * -0.02, size.height * 0.1, 0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
