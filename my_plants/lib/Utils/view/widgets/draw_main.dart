import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawMain extends StatefulWidget {
  const DrawMain({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawMain> createState() => _DrawMainState();
}

class _DrawMainState extends State<DrawMain>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> width;
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 210));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = Tween(begin: size.width * 0.25, end: size.width * 0.75).animate(
      animationController,
    );
    return AnimatedBuilder(
      animation: animationController,
      builder: (_, w) => SizedBox(
          width: width.value,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            child: Drawer(
                elevation: 2,
                child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                        color: ThemeData.light().scaffoldBackgroundColor),
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: size.height * -0.08,
                          child: Transform.rotate(
                            angle: 3,
                            child: Image(
                              image: AssetImage("assets/images/decoration.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        (width.value > size.width * 0.25)
                            ? SafeArea(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _header(
                                      animationController: animationController,
                                    ),
                                    _body()
                                  ],
                                ),
                              )
                            : SafeArea(
                                child: Column(
                                  children: [
                                    _header(
                                      animationController: animationController,
                                      rotation: true,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          _itemMain(
                                              "assets/images/svg/ic_favorite.svg",
                                              ""),
                                          _itemMain(
                                              "assets/images/svg/ic_tip.svg",
                                              ""),
                                          _itemMain(
                                              "assets/images/svg/ic_type.svg",
                                              "types"),
                                          _itemMain(
                                              "assets/images/svg/ic_about.svg",
                                              "about"),
                                          _itemMain(
                                              "assets/images/svg/ic_game.svg",
                                              "game"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ))),
          )),
    );
  }

  Flexible _body() {
    return Flexible(
      flex: 3,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _itemMainExpanded("assets/images/svg/ic_favorite.svg", "Favoritos",
                width.value, ""),
            _itemMainExpanded(
                "assets/images/svg/ic_tip.svg", "Consejos", width.value, ""),
            _itemMainExpanded("assets/images/svg/ic_type.svg",
                "Tipos de plantas", width.value, "types"),
            _itemMainExpanded("assets/images/svg/ic_about.svg",
                "Acerca de la app", width.value, "about"),
            _itemMainExpanded(
                "assets/images/svg/ic_game.svg", "Juego", width.value, "game"),
          ],
        ),
      ),
    );
  }

  Widget _itemMain(String icon, String route) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, route),
          child: Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 30,
              width: 30,
              child: SvgPicture.asset(icon, color: Colors.grey[400])),
        ),
        const Divider()
      ],
    );
  }

  Widget _itemMainExpanded(
      String icon, String title, double width, String route) {
    return Builder(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: size.width * 0.06),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, route),
              child: Row(children: [
                _itemMain(icon, route),
                (width > size.width * 0.55)
                    ? Container(
                        width: width - size.width * 0.35,
                        margin: EdgeInsets.only(left: 10, bottom: 30),
                        child: Text(title,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )))
                    : Container(
                        width: 0,
                        height: 0,
                      ),
              ]),
            ),
          ),
          const Divider()
        ],
      );
    });
  }
}

class _header extends StatelessWidget {
  bool rotation; //know whether to turn the arrow
  final AnimationController animationController;
  _header({
    this.rotation = false,
    required this.animationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: size.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (rotation)
                ? _ButtonExpand(
                    angle: 3.2,
                    animationController: animationController,
                  )
                : _ButtonExpand(
                    animationController: animationController,
                  ),
            Container(
              margin: EdgeInsets.only(bottom: size.width * 0.02),
              child: CircleAvatar(
                maxRadius: 25,
                child: Text("Es"),
              ),
            ),
            Container(
                child: Text((rotation) ? "" : "Opciones",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                    ))),
          ],
        ),
      ),
    );
  }
}

class _ButtonExpand extends StatelessWidget {
  final double angle;
  final AnimationController animationController;

  _ButtonExpand({
    required this.animationController,
    this.angle = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (angle > 0.0) {
          animationController.forward();
        } else {
          animationController.reverse();
        }
      },
      child: Transform.rotate(
        angle: angle,
        child: Container(
            height: 40,
            child: SvgPicture.asset("assets/images/svg/ic_expand.svg")),
      ),
    );
  }
}
