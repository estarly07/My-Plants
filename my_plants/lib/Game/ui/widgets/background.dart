import 'package:flutter/cupertino.dart';

class Background extends CustomPainter {
  Color color;
  Background(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.3);
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.9,
        size.height * 0.05,
        //--------PUNTO FINAL
        size.width * 0.5,
        size.height * 0.28);
    path.lineTo(size.width * 0.1, size.height * 0.5);

    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.005,
        size.height * 0.55,
        //--------PUNTO FINAL
        0,
        size.height * 0.6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
