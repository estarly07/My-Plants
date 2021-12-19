import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressCircular extends StatefulWidget {
  final int lastDay; //How often is it watered
  final int today; //Day counter

  const ProgressCircular({
    Key? key,
    required this.lastDay,
    required this.today,
  }) : super(key: key);

  @override
  State<ProgressCircular> createState() => _ProgressCircularState();
}

class _ProgressCircularState extends State<ProgressCircular>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final porcentaje = (100 - ((widget.today * 100) / widget.lastDay));
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (_, w) => SizedBox(
              width: 25,
              height: 25,
              child: CustomPaint(
                painter: Progress(porcentaje: porcentaje),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 5),
              //MUESTRE EL PORCENTAJE CON NINGUN DECIMAL
              child: Text("${porcentaje.toStringAsFixed(0)}%",
                  style: TextStyle(fontSize: 10)))
        ],
      ),
    );
  }
}

class Progress extends CustomPainter {
  double porcentaje;
  Progress({required this.porcentaje});

  @override
  void paint(Canvas canvas, Size size) {
    //CIRCULO BACKGROUND
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..strokeWidth = 4;

    final center = Offset(size.width / 2, size.height / 2);

    final radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    //CIRCULO DEL PROGRESO
    final paintCirculo = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      //bordes circulares
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    double arcAngel = 2 * pi * (porcentaje / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngel, false, paintCirculo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
