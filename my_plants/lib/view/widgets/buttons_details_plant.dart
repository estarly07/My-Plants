import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_plants/bloc/plants/plants_bloc.dart';

class ButtonDetailsPlant extends StatefulWidget {
  final String text;
  final String caracteristic;
  final String icon;
  final bool showContent;
  const ButtonDetailsPlant(
      {required this.icon,
      required this.text,
      required this.caracteristic,
      this.showContent = false,
      Key? key})
      : super(key: key);

  @override
  State<ButtonDetailsPlant> createState() => _ButtonDetailsPlantState();
}

class _ButtonDetailsPlantState extends State<ButtonDetailsPlant>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacity;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.5, curve: Curves.ease)));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  String caracteristicSave = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("object");
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            /* print("$caracteristicSave ${widget.caracteristic}");
            if (caracteristicSave == widget.caracteristic) {
              BlocProvider.of<PlantsBloc>(context, listen: false)
                  .add(ShowCharacteristicEvent(""));
              animationController.reverse;
              caracteristicSave = "";
            } else { */
            BlocProvider.of<PlantsBloc>(context, listen: false)
                .add(ShowCharacteristicEvent(widget.caracteristic));
            animationController.reset();
            animationController.forward();
            caracteristicSave = widget.caracteristic;
            /*   } */
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            width: size.width * 0.17,
            height: size.width * 0.17,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: -5,
                      color: Colors.black54.withOpacity(0.3),
                      offset: Offset(5, 5)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.white),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: SvgPicture.asset(
                widget.icon,
              ),
            ),
          ),
        ),
        BlocBuilder<PlantsBloc, PlantsState>(
          builder: (context, state) {
            return (state.caracteristic == widget.caracteristic)
                ? AnimatedBuilder(
                    animation: animationController,
                    builder: (_, w) => Opacity(
                      opacity: opacity.value,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: size.width * 0.6,
                        child: GestureDetector(
                          onTap: () {
                            animationController.reverse();
                          },
                          child: CustomPaint(
                              painter: TriangleIndicator(),
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.08),
                                  child: Text(widget.text))),
                        ),
                      ),
                    ),
                  )
                : Container();
          },
        )
      ],
    );
  }
}

class TriangleIndicator extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.1, size.height);
    path.lineTo(size.width * 0.1, size.height * 0.8);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.1, size.height * 0.2);
    path.lineTo(size.width * 0.1, 0);
    canvas.drawShadow(path, Color(0xff000000), 3, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
