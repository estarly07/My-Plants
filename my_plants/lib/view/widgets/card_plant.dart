import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_plants/models/plant.dart';
import 'package:my_plants/view/widgets/progres_circular.dart';

class CardPlant extends StatelessWidget {
  final Plant plant;

  CardPlant({required this.plant});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    margin: EdgeInsets.all(5),
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
                  _ButtonLike()
                ],
              ),
            ],
          ),
          _PlantInfo(
            plant: plant,
          ),
        ],
      ),
    );
  }
}

class _ButtonLike extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: GestureDetector(
          onTap: () => print("object"),
          child: const Icon(
            Icons.favorite_border,
            color: Colors.grey,
            size: 25,
          )),
    );
  }
}

class _PlantInfo extends StatelessWidget {
  final Plant plant;

  const _PlantInfo({
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          _PlantImage(
            image: plant.picture,
          ),
          _PlantDescription(
            plant: plant,
          )
        ],
      ),
    );
  }
}

class _PlantDescription extends StatelessWidget {
  final Plant plant;
  const _PlantDescription({
    required this.plant,
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
                  plant.name,
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
            today: 1,
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
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: FadeInImage(
              placeholder: const AssetImage("assets/images/wait_plant.png"),
              fadeOutDuration: const Duration(seconds: 1),
              image: NetworkImage(image),
              fit: BoxFit.cover,
            )));
  }
}
