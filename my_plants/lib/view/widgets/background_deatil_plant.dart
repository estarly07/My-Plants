import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundDetailPlant extends StatelessWidget {
  const BackgroundDetailPlant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _background(size),
        _decoration(size),
        Container(
            padding: EdgeInsets.only(top: 65, left: 10),
            height: double.infinity,
            width: size.width * 0.7,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/wait_plant.png"),
              image: NetworkImage(
                  "https://www.aldi.es/content/aldi/spain/promotions/source-localenhancement/2021/2021-12/2021-12-09/plantas/3152/0/0/jcr:content/assets/imported-images/BILD_INTERNET1/a51b54bb95e4cbfbde062646dca6.png/jcr:content/renditions/opt.736w.png.res/1638379622407/opt.736w.png"),
              fit: BoxFit.cover,
            )),
      ],
    );
  }

  Container _decoration(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 20, left: 0),
      padding: EdgeInsets.only(left: 10),
      height: double.infinity,
      width: size.width * 0.7,
      child: CustomPaint(
        painter: _Decoration(),
      ),
    );
  }

  Container _background(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 25, left: 0),
      padding: EdgeInsets.only(left: 10),
      height: double.infinity,
      width: size.width * 0.7,
      child: CustomPaint(
        painter: _CustomBackground(),
      ),
    );
  }
}

class _CustomBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff008F39)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width, size.height * 0.05);
    path.lineTo(size.width, size.height * 0.85);
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.5,
        size.height,
        //--------PUNTO FINAL
        size.width * 0.20,
        size.height * 0.88);
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * -0.1,
        size.height * 0.77,
        //--------PUNTO FINAL
        size.width * 0.3,
        size.height * 0.45);

    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.4,
        size.height * 0.35,
        //--------PUNTO FINAL
        size.width * 0.25,
        size.height * 0.28);
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * -0.2,
        size.height * 0.10,
        //--------PUNTO FINAL
        size.width * 0.6,
        size.height * 0.03);
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.8,
        size.height * 0.01,
        //--------PUNTO FINAL
        size.width,
        size.height * 0.05);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Decoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff9ACD32)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width, size.height * 0.15);
    path.lineTo(size.width, size.height * 0.9);
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.5,
        size.height,
        //--------PUNTO FINAL
        size.width * 0.35,
        size.height * 0.9);
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.1,
        size.height * 0.77,
        //--------PUNTO FINAL
        size.width * 0.4,
        size.height * 0.45);

    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.45,
        size.height * 0.35,
        //--------PUNTO FINAL
        size.width * 0.4,
        size.height * 0.15);
/*     path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * -0.2,
        size.height * 0.10,
        //--------PUNTO FINAL
        size.width * 0.6,
        size.height * 0.03); */
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.4,
        size.height * -0.1,
        //--------PUNTO FINAL
        size.width,
        0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
