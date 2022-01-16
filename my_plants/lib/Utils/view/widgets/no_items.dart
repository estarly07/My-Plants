import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';

class NoItems extends StatelessWidget {
  final String animation;
  final String title;
  final String description;
  final bool showArrowDown;
  final double width;
  const NoItems(
      {Key? key,
      required this.animation,
      required this.title,
      required this.description,
      this.showArrowDown = false,
      this.width = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.2,
      ),
      child: Column(
        children: [
          Lottie.asset(animation,
              repeat: true,
              animate: true,
              width: (width == 0.0) ? size.width * 0.5 : width),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.03),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: size.height * 0.02,
            ),
          ),
          (showArrowDown)
              ? Icon(Icons.arrow_downward, color: Colors.grey)
              : Container()
        ],
      ),
    );
  }
}
