import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_plants/Utils/values/global.dart';
import 'package:my_plants/Utils/bloc/bloc.dart';
import 'package:my_plants/Tip/model/tip.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

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
          navigatorBloc.add(ShowNavigationBarEvent());
        }
      } else {
        _oldY = scrollControler.offset;
        if (!_showNavigator) {
          _showNavigator = true;
          navigatorBloc.add(ShowNavigationBarEvent());
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = BlocProvider.of<PlantsBloc>(context, listen: false);
    return ListView(
        controller: scrollControler,
        physics: BouncingScrollPhysics(),
        children: [
          CustomAppbar(
            icons: [buttonAppaBar["main"]!, buttonAppaBar["search"]!],
          ),
          ElasticIn(child: TitlePage(title: "Tus plantas")),
          FadeInUp(child: _tip()),
          FadeInUp(
            child: BlocBuilder<PlantsBloc, PlantsState>(
              builder: (context, state) {
                return GridView(
                  shrinkWrap: true, // You won't see infinite size error
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ...state.plants
                        .map((plant) => GestureDetector(
                              onTap: () {
                                if (state.idPlantsSelects.isEmpty) {
                                  Navigator.pushNamed(context, "detail",
                                      arguments: plant);
                                } else {
                                  provider
                                      .add(SelectPlanstEvent(plant.idPlant!));
                                }
                              },
                              onLongPress: () {
                                provider.add(SelectPlanstEvent(plant.idPlant!));
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CardPlant(
                                    plant: plant,
                                  ),
                                  (state.idPlantsSelects
                                          .contains(plant.idPlant))
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black54
                                                  .withOpacity(0.3),
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
}
