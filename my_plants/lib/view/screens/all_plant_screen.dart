import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_plants/Utils/global.dart';
import 'package:my_plants/bloc/bloc.dart';
import 'package:my_plants/bloc/plants/plants_bloc.dart';
import 'package:my_plants/models/tip.dart';
import 'package:my_plants/view/widgets/widgets.dart';

class AllPlantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Layout();
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
  List<int> idsPlantsSelect = [];
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
          CustomAppbar(
            icons: [buttonAppaBar["main"]!, buttonAppaBar["search"]!],
          ),
          TitlePage(title: "Tus plantas"),
          _tip(),
          BlocBuilder<PlantsBloc, PlantsState>(
            builder: (context, state) {
              return GridView(
                shrinkWrap: true, // You won't see infinite size error
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ...state.plants
                      .map((plant) => GestureDetector(
                            onTap: () {
                              if (idsPlantsSelect.isEmpty) {
                                Navigator.pushNamed(context, "detail",
                                    arguments: plant);
                              } else {
                                _selectPlant(plant.idPlant);
                              }
                            },
                            onLongPress: () {
                              _selectPlant(plant.idPlant);
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CardPlant(
                                  plant: plant,
                                ),
                                (idsPlantsSelect.contains(plant.idPlant))
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
            },
          ),
        ]);
  }

  BlocBuilder<TipsBloc, TipsState> _tip() {
    return BlocBuilder<TipsBloc, TipsState>(
      builder: (context, state) {
        return state.tipRandom == null
            ? TipCard(
                tip: Tip(
                    id: "id",
                    picture: "assets/images/svg/abonar.svg",
                    tip: "Cargando consejos...",
                    url: ""),
              )
            : TipCard(
                tip: state.tipRandom!,
              );
      },
    );
  }

  void _selectPlant(int? idPlant) {
    if (idsPlantsSelect.isEmpty) {
      idsPlantsSelect.add(idPlant!);
    } else {
      bool isDuplicate = false;
      for (var id in idsPlantsSelect) {
        if (id == idPlant) {
          isDuplicate = true;
        }
      }
      if (isDuplicate) {
        idsPlantsSelect.remove(idPlant!);
      } else {
        idsPlantsSelect.add(idPlant!);
      }
    }
    BlocProvider.of<PlantsBloc>(context, listen: false)
        .add(SelectPlanstEvent(idsPlantsSelect));
  }
}
