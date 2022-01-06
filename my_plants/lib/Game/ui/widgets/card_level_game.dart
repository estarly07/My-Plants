import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Game/bloc/game_bloc.dart';
import 'package:my_plants/Game/model/card_game.dart';
import 'package:my_plants/Type_plant/bloc/type_plants_bloc.dart';
import 'package:my_plants/Type_plant/model/type_plant.dart';

class CardLevelGame extends StatelessWidget {
  final int cantCards;
  final String title;
  final String image;
  const CardLevelGame({
    required this.cantCards,
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => generatePlants(context, cantCards),
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.02),
        height: size.height * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.02),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 15,
                  color: Colors.black54,
                  spreadRadius: -5,
                  offset: Offset(5, 5))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(image),
              height: size.height * 0.15,
              width: size.height * 0.15,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  void generatePlants(BuildContext context, int cantCards) {
    final typesPlants = BlocProvider.of<TypesPlantsBloc>(context).state.plants;
    List<TypePlant> plants = [];
    for (var i = 0; i < cantCards; i++) {
      plants.add(typesPlants[i]);
    }

    List<int> indexWithDuo = []; //indices que ya salieron 2 veces
    List<TypePlant> plantsSort = [];
    for (var i = 0; i < (plants.length * 2); i++) {
      int indexRandom = Random().nextInt(plants.length);
      if (plantsSort.isEmpty) {
        plantsSort.add(plants[indexRandom]);
      } else {
        if (plantsSort.contains(plants[indexRandom])) {
          if (indexWithDuo.isEmpty || !indexWithDuo.contains(indexRandom)) {
            plantsSort.add(plants[indexRandom]);
            indexWithDuo.add(indexRandom);
          } else {
            i--;
          }
        } else {
          plantsSort.add(plants[indexRandom]);
        }
      }
    }
    List<CardGameModel> cards = [];
    for (var i = 0; i < plantsSort.length; i++) {
      cards.add(CardGameModel(
          index: i,
          photo: plantsSort[i].picture,
          name: plantsSort[i].name,
          visible: true));
    }

    BlocProvider.of<GameBloc>(context, listen: false)
        .add(GameStartEvent(false, cards, "game"));
  }
}
