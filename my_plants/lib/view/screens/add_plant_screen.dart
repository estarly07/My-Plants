import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPlantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(physics: BouncingScrollPhysics(), children: [
        CardAddPlant(),
        CardAddPlant(),
        CardAddPlant(),
        CardAddPlant(),
        CardAddPlant(),
        CardAddPlant(),
        CardAddPlant(),
      ]),
    ));
  }
}

class CardAddPlant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: size.height * 0.3,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.08,
                  width: double.infinity,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.03,
            left: size.width * 0.03,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Container(
                    color: Colors.pink[100],
                    height: size.height * 0.23,
                    width: size.width * 0.3,
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  width: size.width * 0.7,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
