import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/bloc/navigation_bar/navigation_bar_bloc.dart';
import 'package:my_plants/bloc/plants/plants_bloc.dart';
import 'package:my_plants/services/plants_service.dart';
import 'package:my_plants/view/widgets/tip_card.dart';
import 'package:my_plants/view/widgets/title_page.dart';
import 'package:my_plants/view/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlantServices().getAllPlants(context);
    return Scaffold(
      body: Stack(
        children: [
          _Layout(),
          _Navigation(),
        ],
      ),
    );
  }
}

class _Layout extends StatefulWidget {
  const _Layout({
    Key? key,
  }) : super(key: key);

  @override
  State<_Layout> createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
  late ScrollController scrollControler;
  double _oldY = 0.0;
  bool _showNavigator = true;
  @override
  void initState() {
    final navigatorBloc =
        BlocProvider.of<NavigationBarBloc>(context, listen: false);
    scrollControler = ScrollController();
    scrollControler.addListener(() {
      if (_oldY < scrollControler.offset && scrollControler.offset > 150) {
        _oldY = scrollControler.offset;
        if (_showNavigator) {
          _showNavigator = false;
          navigatorBloc.add(ShowNavigationBarEvent(show: _showNavigator));
        }
      } else {
        _oldY = scrollControler.offset;
        if (!_showNavigator) {
          _showNavigator = true;
          navigatorBloc.add(ShowNavigationBarEvent(show: _showNavigator));
        }
      }
      //print(_oldY);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollControler.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
        controller: scrollControler,
        physics: BouncingScrollPhysics(),
        children: [
          TitlePage(),
          TipCard(),
          BlocBuilder<PlantsBloc, PlantsState>(
            builder: (context, state) {
              return GridView(
                shrinkWrap: true, // You won't see infinite size error
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ...state.plants
                      .map((plant) => CardPlant(
                            plant: plant,
                          ))
                      .toList()
                ],
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: (size.width * 0.5),
                    mainAxisExtent: (size.height * 0.37),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
              );
            },
          ),
        ]);
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
