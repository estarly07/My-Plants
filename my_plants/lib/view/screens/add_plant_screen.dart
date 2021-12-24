import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Utils/global.dart';

import 'package:my_plants/bloc/bloc.dart';
import 'package:my_plants/models/type_plant.dart';
import 'package:my_plants/models/plant_local.dart';
import 'package:my_plants/services/database_service.dart';
import 'package:my_plants/services/services.dart';
import 'package:my_plants/view/widgets/dialog.dart';
import 'package:my_plants/view/widgets/widgets.dart';

class AddPlantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        const BackgrounScreenCustom(),
        SafeArea(
          child: BlocBuilder<TypesPlantsBloc, TypesPlantsState>(
            builder: (context, state) {
              return (state.plants.isNotEmpty)
                  ? ListView.builder(
                      itemCount: state.plants.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, index) =>
                          CardAddPlant(typePlant: state.plants[index]))
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    ));
  }
}

class CardAddPlant extends StatelessWidget {
  final TypePlant typePlant;

  const CardAddPlant({Key? key, required this.typePlant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
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
                    margin: const EdgeInsets.only(right: 15, bottom: 15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 15,
                              spreadRadius: -5,
                              color: Colors.black54.withOpacity(0.3),
                              offset: Offset(3, 3))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                            top: -80,
                            left: 1,
                            right: -70,
                            child:
                                Opacity(opacity: 0.55, child: _decoration())),
                        _infoPlant(size),
                      ],
                    ),
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
                    color: colors[Random().nextInt(colors.length)],
                    height: size.height * 0.23,
                    width: size.width * 0.33,
                    child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage("assets/images/wait_plant.png"),
                        image: NetworkImage(typePlant.picture)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _decoration() => Container(
        child:
            Image(image: AssetImage("assets/images/decoration_card_add.png")),
      );

  Container _infoPlant(Size size) {
    return Container(
      padding:
          EdgeInsets.only(top: size.height * 0.03, left: size.height * 0.05),
      height: double.infinity,
      width: size.width * 0.7,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${typePlant.name}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(typePlant.nameScientific),
                  _buttonAdd(size)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonAdd(Size size) {
    return Builder(builder: (context) {
      return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            showDialogCustom(context, (String name) {
              insertPlant(name);
            }, "Añade tu planta");
          },
          child: Container(
            margin: EdgeInsets.only(right: size.width * 0.05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xff00a000).withOpacity(0.7),
            ),
            height: size.height * 0.045,
            width: size.width * 0.25,
            child: const Center(
                child: Text("Añadir",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          ),
        ),
      );
    });
  }

  Future insertPlant(String name) async {
    DataBaseService().insertPlant(Plant(
        name: name,
        nameScientific: typePlant.nameScientific,
        daySummer: typePlant.maintenance.daySummer,
        dayWinter: typePlant.maintenance.dayWinter,
        days: 0,
        typePlant: typePlant.id));
  }
}
