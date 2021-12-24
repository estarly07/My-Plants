import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Utils/global.dart';
import 'package:my_plants/bloc/bloc.dart';
import 'package:my_plants/models/type_plant.dart';

class TypePlantsScreen extends StatelessWidget {
  const TypePlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TypesPlantsBloc, TypesPlantsState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.plants.length,
            itemBuilder: (context, index) =>
                TypesCard(typePlant: state.plants[index]),
          );
        },
      ),
    );
  }
}

class TypesCard extends StatelessWidget {
  final TypePlant typePlant;
  const TypesCard({
    required this.typePlant,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, "detail_types", arguments: typePlant),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: size.height * 0.23,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 15,
                  offset: Offset(5, 5),
                  spreadRadius: -10,
                  color: Colors.black54)
            ]),
            child: Row(
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${typePlant.name}",
                            maxLines: 1,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "${typePlant.description}",
                                maxLines: 7,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                _Image(typePlant: typePlant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required this.typePlant,
  }) : super(key: key);

  final TypePlant typePlant;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 2,
        child: Container(
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: DecorationCardType(
                        color: colors[Random().nextInt(colors.length)]!),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FadeInImage(
                    placeholder: AssetImage("assets/images/wait_plant.png"),
                    image: NetworkImage(typePlant.picture)),
              )
            ],
          ),
        ));
  }
}

class DecorationCardType extends CustomPainter {
  final Color color;
  DecorationCardType({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.4, size.height);
    path.quadraticBezierTo(-20, size.height * 0.5, size.width * 0.4, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
