import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final bool tap;
  TextCustom(
      {Key? key, required this.size, required this.text, this.tap = false})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: size.width * 0.05,
            color: (tap) ? Colors.green[900] : Colors.grey[200]));
  }
}
