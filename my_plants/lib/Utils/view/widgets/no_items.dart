import 'package:animate_do/animate_do.dart';
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
          ElasticInDown(
              duration: Duration(milliseconds: 750),
              child: Lottie.asset(animation,
                  repeat: true,
                  animate: true,
                  width: (width == 0.0) ? size.width * 0.5 : width)),
          ElasticInUp(
            duration: Duration(milliseconds: 500),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.03),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElasticInUp(
            duration: Duration(milliseconds: 650),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: size.height * 0.02,
              ),
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
