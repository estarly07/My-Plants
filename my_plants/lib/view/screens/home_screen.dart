import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_plants/view/widgets/tip_card.dart';
import 'package:my_plants/view/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  @override
  void initState() {
    scrollControler = ScrollController();
    scrollControler.addListener(() {
      print("object");
    });
    super.initState();
  }

  final a = ["", "", "", "", ""];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(physics: BouncingScrollPhysics(), children: [
      TipCard(),
      GridView(
        shrinkWrap: true, // You won't see infinite size error
        physics: NeverScrollableScrollPhysics(),
        children: [...a.map((e) => CardPlant()).toList()],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: (size.width * 0.5),
            mainAxisExtent: (size.height * 0.37),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
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
