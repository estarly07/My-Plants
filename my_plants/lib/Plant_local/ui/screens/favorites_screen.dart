import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Plant_local/bloc/plants_bloc.dart';
import 'package:my_plants/Plant_local/ui/widgets/card_plant.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BlocProvider.of<PlantsBloc>(context).add(GetPlantsFavoritesEvent());
    return Scaffold(body: FadeInUp(
        child: BlocBuilder<PlantsBloc, PlantsState>(builder: (context, state) {
      return (state.plantsFavorites.isEmpty)
          ? Container(
              margin: EdgeInsets.only(top: size.height * 0.25),
              child: NoItems(
                  animation: "assets/animations/no_plants_three.json",
                  title: "No tienes plantas favoritas :(",
                  description: "Guarda una planta como favorita."),
            )
          : GridView(
              shrinkWrap: true, // You won't see infinite size error
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...state.plantsFavorites
                    .map((plant) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "detail",
                                arguments: plant);
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CardPlant(
                                plant: plant,
                              ),
                              (state.idPlantsSelects.contains(plant.idPlant))
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.black54.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.symmetric(
                                          vertical: (size.width * 0.013),
                                          horizontal: 5),
                                    )
                                  : Container()
                            ],
                          ),
                        ))
                    .toList()
              ],
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: (size.width * 0.5),
                  mainAxisExtent: (size.height * 0.37),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12),
            );
    })));
  }
}
