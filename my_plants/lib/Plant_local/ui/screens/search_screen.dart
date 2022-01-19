import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Plant_local/bloc/plants_bloc.dart';
import 'package:my_plants/Plant_local/model/plant_local.dart';
import 'package:my_plants/Plant_local/ui/widgets/card_plant.dart';
import 'package:my_plants/Utils/view/widgets/no_items.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    final provider = BlocProvider.of<PlantsBloc>(context, listen: false);
    _controller.addListener(() {
      if (query != _controller.text && _controller.text.isNotEmpty) {
        query = _controller.text;
        print("Q $query");
        provider.add(SearchPlantsEvent(query));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String query = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          print("HOLAAA");
          return true;
        },
        child: Scaffold(
          body: Container(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.03,
                      right: size.width * 0.03,
                      top: size.width * 0.1),
                  child: Text(
                    "Buscador",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.03,
                      right: size.width * 0.03,
                      top: size.width * 0.1),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: size.width * 0.07,
                        horizontal: size.width * 0.03),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          spreadRadius: -5,
                          blurRadius: 5,
                          color: Colors.black54),
                    ], color: ThemeData.light().scaffoldBackgroundColor),
                    child: TextFormField(
                      maxLines: 1,
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      cursorColor: Color(0xff008F39),
                      onChanged: (v) {},
                      decoration: InputDecoration(
                          hintText: "Ingresa un nombre.",
                          suffixIcon: Icon(
                            Icons.search,
                            color: Color(0xff008F39),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                BlocBuilder<PlantsBloc, PlantsState>(
                    builder: (context, state) => _Body(
                          plants: state.plantsSearched,
                        )),
              ],
            ),
          ),
        ));
  }
}

class _Body extends StatelessWidget {
  final List<Plant> plants;
  const _Body({
    Key? key,
    required this.plants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print(plants.length);
    return (plants.isEmpty)
        ? Container(
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: NoItems(
                animation: "assets/animations/search.json",
                title: "No se encontro la planta.",
                description: "Prueba ingresando otro"),
          )
        : GridView(
            shrinkWrap: true, // You won't see infinite size error
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...plants
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
  }
}
