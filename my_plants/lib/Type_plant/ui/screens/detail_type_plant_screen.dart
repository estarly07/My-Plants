import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_plants/Utils/values/global.dart';
import 'package:my_plants/Type_plant/model/type_plant.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

class DetailTypeScreen extends StatelessWidget {
  late TypePlant typePlant;
  DetailTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    typePlant = ModalRoute.of(context)!.settings.arguments as TypePlant;
    final size = MediaQuery.of(context).size;
    final color = colors[Random().nextInt(colors.length)]!;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgrounScreenCustom(),
          _decoration(color: color),
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            child: FadeInDown(
                              child: FadeInImage(
                                  fit: BoxFit.contain,
                                  placeholder: AssetImage(
                                      "assets/images/wait_plant.png"),
                                  image: NetworkImage(typePlant.picture)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    FadeInLeft(
                        delay: Duration(milliseconds: 500),
                        child: _title(
                            txt: typePlant.name, fontSize: size.width * 0.1)),
                    FadeInLeft(
                      delay: Duration(milliseconds: 750),
                      child: Text(
                        typePlant.nameScientific,
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeIn(
                      delay: Duration(milliseconds: 500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardCarasteristic(
                              title: typePlant.maintenance.idealTemperature,
                              content: "Temperatura ideal"),
                          CardCarasteristic(
                              title: typePlant.maintenance.minimumTemperature,
                              content: "Temperatura m??nima"),
                        ],
                      ),
                    ),
                    FadeIn(
                      delay: Duration(milliseconds: 700),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardCarasteristic(
                              title: "${typePlant.maintenance.daySummer}",
                              content: "Cada cuanto se riega\n en verano"),
                          CardCarasteristic(
                              title: "${typePlant.maintenance.dayWinter}",
                              content: "Cada cuanto se riega\n en invierno"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FadeInUp(
                      delay: Duration(milliseconds: 500),
                      child: Container(
                        child: Text(
                          typePlant.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.grey[850],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FadeInUp(
                      delay: Duration(milliseconds: 1000),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CardCarasteristic(
                              title: "Riego",
                              content: typePlant.maintenance.irrigation),
                          CardCarasteristic(
                              title: "Luz solar",
                              content: typePlant.maintenance.sunlight),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _title extends StatelessWidget {
  final String txt;
  final double fontSize;
  const _title({required this.txt, required this.fontSize, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.bold, fontFamily: "Ice"),
    );
  }
}

class _decoration extends StatelessWidget {
  const _decoration({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: _DecorationHeader(color),
          ),
        ],
      ),
    );
  }
}

class CardCarasteristic extends StatelessWidget {
  final String title;
  final String content;

  const CardCarasteristic(
      {required this.title, required this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(5),
      /*      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ThemeData.light().scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(blurRadius: 15, spreadRadius: -10, color: Colors.black54)
          ]), */
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _title(txt: title, fontSize: 25),
          Text(
            "${content}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorationHeader extends CustomPainter {
  Color color;

  _DecorationHeader(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(
        size.width * 0.13, size.height * 0.53, size.width, size.height * 0.45);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
