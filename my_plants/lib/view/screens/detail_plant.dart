import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_plants/Utils/global.dart';
import 'package:my_plants/bloc/bloc.dart';
import 'package:my_plants/models/plant_local.dart';
import 'package:my_plants/models/type_plant.dart';
import 'package:my_plants/view/widgets/widgets.dart';

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
                  TitlePage(
                    title: plant.name,
                  ),
                  DetailsPlant(
                    plant: typePlant!,
                  ),
                  InfoPlant(typePlant.description)
                ],
              ),
            )));
  }
}

class InfoPlant extends StatelessWidget {
  String content;
  InfoPlant(this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Información",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, fontFamily: "Ice"),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              content,
              style: TextStyle(color: Colors.grey[700]),
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
                  ButtonDetailsPlant(
                      icon: buttonsDetailPlants["minimumTemperature"]!,
                      caracteristic: "minimumTemperature",
                      showContent: state.caracteristic == "minimumTemperature"
                          ? true
                          : false,
                      text: plant.maintenance.minimumTemperature),
                  ButtonDetailsPlant(
                      icon: buttonsDetailPlants["idealTemperature"]!,
                      caracteristic: "idealTemperature",
                      showContent: state.caracteristic == "idealTemperature"
                          ? true
                          : false,
                      text: plant.maintenance.idealTemperature),
                  ButtonDetailsPlant(
                      icon: buttonsDetailPlants["sunlight"]!,
                      caracteristic: "sunlight",
                      showContent:
                          state.caracteristic == "sunlight" ? true : false,
                      text: plant.maintenance.sunlight),
                  ButtonDetailsPlant(
                      icon: buttonsDetailPlants["irrigation"]!,
                      caracteristic: "irrigation",
                      showContent:
                          state.caracteristic == "irrigation" ? true : false,
                      text: plant.maintenance.irrigation),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
