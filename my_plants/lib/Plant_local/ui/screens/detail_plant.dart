import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:my_plants/Utils/values/global.dart';
import 'package:my_plants/Utils/bloc/bloc.dart';
import 'package:my_plants/Plant_local/model/plant_local.dart';
import 'package:my_plants/Type_plant/model/type_plant.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

class DetailPlant extends StatelessWidget {
  const DetailPlant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plant = ModalRoute.of(context)!.settings.arguments as Plant;
    TypePlant? typePlant;
    final blocPlant = BlocProvider.of<TypesPlantsBloc>(context, listen: false);

    for (var type in blocPlant.state.plants) {
      if (type.id == plant.typePlant) {
        typePlant = type;
      }
    }
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppbar(
                    icons: [buttonAppaBar["left"]!],
                  ),
                  DetailsPlant(
                    plant: typePlant!,
                  ),
                  InfoPlant(typePlant.description, plant, plant.saved)
                ],
              ),
            )));
  }
}

class InfoPlant extends StatefulWidget {
  final String content;
  final Plant plant;
  bool saved;
  InfoPlant(this.content, this.plant, this.saved);

  @override
  State<InfoPlant> createState() => _InfoPlantState();
}

class _InfoPlantState extends State<InfoPlant> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeInUp(
                  delay: Duration(milliseconds: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.plant.name,
                        style: TextStyle(
                            fontSize: size.height * 0.05,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      Text(
                        widget.plant.nameScientific,
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.saved = !widget.saved;
                    BlocProvider.of<PlantsBloc>(context, listen: false).add(
                        SavedPlantEvent(widget.saved, widget.plant.idPlant!));
                    setState(() {});
                  },
                  child: ElasticInRight(
                    child: Container(
                      child: (widget.saved)
                          ? Lottie.asset("assets/animations/like.json",
                              animate: widget.saved,
                              repeat: false,
                              height: size.height * 0.075,
                              width: size.height * 0.075)
                          : Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.favorite_outline_rounded,
                                color: Colors.grey,
                                size: size.height * 0.045,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
          FadeInUp(
            delay: Duration(milliseconds: 200),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                widget.content,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPlant extends StatelessWidget {
  final TypePlant plant;
  const DetailsPlant({
    required this.plant,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.55,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: size.width * 0.3,
              ),
              BackgroundDetailPlant(plant.picture),
            ],
          ),
        ),
        BlocBuilder<TypesPlantsBloc, TypesPlantsState>(
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              height: size.height * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FadeInLeft(
                    delay: Duration(milliseconds: 100),
                    child: ButtonDetailsPlant(
                        icon: buttonsDetailPlants["minimumTemperature"]!,
                        caracteristic: "minimumTemperature",
                        showContent: state.caracteristic == "minimumTemperature"
                            ? true
                            : false,
                        text: plant.maintenance.minimumTemperature),
                  ),
                  FadeInLeft(
                    delay: Duration(milliseconds: 200),
                    child: ButtonDetailsPlant(
                        icon: buttonsDetailPlants["idealTemperature"]!,
                        caracteristic: "idealTemperature",
                        showContent: state.caracteristic == "idealTemperature"
                            ? true
                            : false,
                        text: plant.maintenance.idealTemperature),
                  ),
                  FadeInLeft(
                    delay: Duration(milliseconds: 300),
                    child: ButtonDetailsPlant(
                        icon: buttonsDetailPlants["sunlight"]!,
                        caracteristic: "sunlight",
                        showContent:
                            state.caracteristic == "sunlight" ? true : false,
                        text: plant.maintenance.sunlight),
                  ),
                  FadeInLeft(
                    delay: Duration(milliseconds: 400),
                    child: ButtonDetailsPlant(
                        icon: buttonsDetailPlants["irrigation"]!,
                        caracteristic: "irrigation",
                        showContent:
                            state.caracteristic == "irrigation" ? true : false,
                        text: plant.maintenance.irrigation),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
