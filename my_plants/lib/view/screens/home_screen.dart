import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_plants/bloc/bloc.dart';
import 'package:my_plants/services/services.dart';
import 'package:my_plants/view/screens/screens.dart';
import 'package:my_plants/view/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TypesPlantServices().getAllPlants(context);
    DataBaseService().getAllPlants(context);
    TipsService().getTips(context);
    return Scaffold(
      drawer: DrawMain(),
      body: Stack(
        children: [
          BlocBuilder<TypesPlantsBloc, TypesPlantsState>(
            builder: (context, state) {
              return (state.plants.isEmpty)
                  ? Center(child: CircularProgressIndicator())
                  : _screens();
            },
          ),
          _Navigation(),
        ],
      ),
      floatingActionButton:
          BlocBuilder<PlantsBloc, PlantsState>(builder: (context, state) {
        final isSelecting = state.idPlantsSelects.isNotEmpty;
        return GestureDetector(
          onTap: () async {
            if (isSelecting) {
              await DataBaseService().deletePlantsSelected(
                  context: context, idsPlants: state.idPlantsSelects);
            } else {
              Navigator.pushNamed(context, "add");
            }
          },
          child: Container(
            width: 60,
            height: 60,
            decoration:
                BoxDecoration(color: Color(0xff008F39), shape: BoxShape.circle),
            child: isSelecting
                ? const Icon(Icons.delete, color: Colors.white)
                : const Icon(Icons.add, color: Colors.white),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _screens() =>
      BlocBuilder<NavigationBarBloc, NavigationBarState>(builder: (_, state) {
        switch (state.route) {
          case "home":
            {
              return AllPlantScreen();
            }
          case "recent":
            {
              return RecentScreen();
            }
          default:
            {
              return Container();
            }
        }
      });
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        child: Align(alignment: Alignment.bottomCenter, child: NavigationBar()),
      ),
    );
  }
}
