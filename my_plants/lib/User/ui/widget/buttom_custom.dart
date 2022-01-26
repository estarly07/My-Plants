import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtomCustom extends StatelessWidget {
  final double width, height;
  final String text;
  const ButtomCustom(
      {Key? key, required this.width, required this.height, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      margin: EdgeInsets.only(top: size.width * 0.01),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.05)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold),
      ),
    );
  }
}
