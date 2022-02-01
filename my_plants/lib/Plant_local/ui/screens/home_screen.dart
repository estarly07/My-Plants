import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_plants/User/bloc/user_bloc.dart';

import 'package:my_plants/Utils/bloc/bloc.dart';
import 'package:my_plants/Utils/services/services.dart';
import 'package:my_plants/Utils/view/screens/screens.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BlocProvider.of<PlantsBloc>(context, listen: false).add(GetPlanstEvent());
    BlocProvider.of<TypesPlantsBloc>(context, listen: false)
        .add(GetAllPlantEvent());
    BlocProvider.of<TipsBloc>(context, listen: false).add(GetTipsEvent());
    return Scaffold(
      drawer: DrawMain(
        user: BlocProvider.of<UserBloc>(context, listen: false).state.user!,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getPlants(context);
        },
        child: Stack(
          children: [
            BlocBuilder<TypesPlantsBloc, TypesPlantsState>(
              builder: (context, state) {
                return (state.plants.isEmpty)
                    ? FadeIn(
                        child: Center(
                            child: Lottie.asset(
                                "assets/animations/handling.json",
                                height: size.width * 0.3,
                                width: size.width * 0.3)),
                      )
                    : FadeInUp(child: _screens());
              },
            ),
            _Navigation(),
          ],
        ),
      ),
      floatingActionButton:
          BlocBuilder<PlantsBloc, PlantsState>(builder: (context, state) {
        final isSelecting = state.idPlantsSelects.isNotEmpty;
        return GestureDetector(
          onTap: () {
            if (isSelecting) {
              BlocProvider.of<PlantsBloc>(context, listen: false)
                  .add(DeletePlantEvent(context));
            } else {
              Navigator.pushNamed(context, "add");
            }
          },
          child: Container(
              width: size.width * 0.17,
              height: size.width * 0.17,
              decoration: BoxDecoration(
                  color: Color(0xff008F39), shape: BoxShape.circle),
              child: isSelecting
                  ? Lottie.asset(
                      "assets/animations/delet.json",
                      fit: BoxFit.contain,
                    )
                  : Lottie.asset(
                      "assets/animations/add.json",
                      fit: BoxFit.contain,
                    )),
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

  Future<void> getPlants(BuildContext context) async {
    BlocProvider.of<PlantsBloc>(context, listen: false).add(GetPlanstEvent());
    return Future.delayed(Duration(seconds: 2));
  }
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
