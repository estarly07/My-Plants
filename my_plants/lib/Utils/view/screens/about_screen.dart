import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_plants/Utils/values/global.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        child: ListView(
          children: [
            ElasticIn(child: _Header(size: size)),
            SizedBox(
              height: size.height * 0.05,
            ),
            FadeInLeft(
              delay: Duration(milliseconds: 50),
              child: Container(
                margin: EdgeInsets.only(left: size.width * 0.02),
                child: Text(
                  "Programador  🖥️",
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FadeInLeft(
              delay: Duration(milliseconds: 200),
              child: Container(
                  margin: EdgeInsets.only(left: size.width * 0.04),
                  child: Text(" Estarly Jesús Amaya T.")),
            ),
            FadeInDown(
              delay: Duration(milliseconds: 200),
              child: Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.02,
                    top: size.height * 0.1,
                    bottom: size.height * 0.02),
                child: Text(
                  "Misión  💼",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FadeInDown(
              delay: Duration(milliseconds: 400),
              child: Container(
                margin: EdgeInsets.only(left: size.width * 0.03),
                child: Text(
                  mision,
                  textAlign: TextAlign.justify,
                  style: TextStyle(),
                ),
              ),
            ),
            FadeInDown(
              delay: Duration(milliseconds: 450),
              child: Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.03, top: size.height * 0.05),
                child: Text(
                  "Características",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: size.height * 0.025),
                ),
              ),
            ),
            FadeInLeft(
                delay: Duration(milliseconds: 200),
                child: _Point(text: "Controla todas las plantas de casa.")),
            FadeInLeft(
              delay: Duration(milliseconds: 300),
              child: _Point(
                  text:
                      "Recibe notificaciones cuando una planta necesite agua."),
            ),
            FadeInLeft(
                delay: Duration(milliseconds: 400),
                child: _Point(text: "Ayuda para intervarlos de regadio.")),
            Container(
              margin: EdgeInsets.only(
                  left: size.width * 0.03, top: size.height * 0.05),
              child: Text(
                "¿Cómo usarla?",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: size.height * 0.025),
              ),
            ),
            _Point(text: "Elige una de las plantas."),
            _Point(
                text:
                    "Agrégala a la app con el nombre para identificarla con más facilidad"),
            _Point(text: "Seleccionala si es una de tus favoritas"),
            Container(
              margin: EdgeInsets.only(
                  left: size.width * 0.03, top: size.height * 0.05),
              child: Text(
                "¡Ya está! My plants te notificará cunado la planta necesite agu. Marca la planta como regada cuando ya lo hayas hecho." +
                    "Ahora zgrega más plantas y diviertete regándolas",
                textAlign: TextAlign.justify,
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Point extends StatelessWidget {
  final String text;
  const _Point({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.width * 0.05),
      child: Row(
        children: [
          Container(
              height: size.height * 0.015,
              width: size.height * 0.015,
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.only(left: size.width * 0.03),
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            color: Colors.purple,
            child: Image.asset(
              "assets/images/fondo.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: size.height * 0.3,
            width: size.width,
            child: CustomPaint(
              painter: _Decoration(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(size.width * 0.1)),
              child: Container(
                  height: size.height * 0.15,
                  width: size.height * 0.15,
                  child: Image(
                    image: AssetImage("assets/images/yo.jpg"),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class _Decoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffF5F5F5)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height * 0.3);
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.75);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
