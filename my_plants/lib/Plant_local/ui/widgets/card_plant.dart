import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';
import 'package:my_plants/Plant_local/model/plant_local.dart';

import 'package:my_plants/Type_plant/model/type_plant.dart';
import 'package:my_plants/Type_plant/repository/services/plants_service.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

class CardPlant extends StatelessWidget {
  final Plant plant;
  late TypePlant typePlant;
  CardPlant({required this.plant});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    for (var typePlant in TypesPlantServices.allTypePlants) {
      if (plant.typePlant == typePlant.id) {
        this.typePlant = typePlant;
        break;
      }
    }
    return Container(
      height: (size.width * 0.5),
      width: (size.height * 0.37),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Stack(
                children: [
                  Container(
                    height: size.height * 0.22,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: -4,
                              offset: Offset(10, 10))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  _ButtonLike(
                    saved: plant.saved,
                  )
                ],
              ),
            ],
          ),
          _PlantInfo(
            typePlant: typePlant,
            plant: plant,
          ),
        ],
      ),
    );
  }
}

class _ButtonLike extends StatefulWidget {
  final bool saved;

  const _ButtonLike({Key? key, required this.saved}) : super(key: key);

  @override
  State<_ButtonLike> createState() => _ButtonLikeState();
}

class _ButtonLikeState extends State<_ButtonLike> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Container(
          height: size.height * 0.05,
          width: size.height * 0.05,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: (widget.saved)
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.grey,
                )),
    );
  }
}

class _PlantInfo extends StatelessWidget {
  final TypePlant typePlant;
  final Plant plant;

  const _PlantInfo({
    required this.typePlant,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          _PlantImage(
            image: typePlant.picture,
          ),
          _PlantDescription(
            plant: typePlant,
            name: plant.name,
            days: plant.days,
          )
        ],
      ),
    );
  }
}

class _PlantDescription extends StatelessWidget {
  final TypePlant plant;
  final String name;
  final int days;
  const _PlantDescription({
    required this.plant,
    required this.name,
    required this.days,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.height * 0.135,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
              Container(
                width: size.height * 0.135,
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  plant.nameScientific,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              )
            ],
          ),
          ProgressCircular(
            lastDay: plant.maintenance.daySummer,
            today: days,
          )
        ],
      ),
    );
  }
}

class _PlantImage extends StatelessWidget {
  final String image;
  const _PlantImage({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: FadeInImage(
              placeholder: const AssetImage("assets/images/wait_plant.png"),
              fadeOutDuration: const Duration(seconds: 1),
              image: NetworkImage(image),
              fit: BoxFit.cover,
            )));
  }
}
