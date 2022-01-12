import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_plants/Utils/values/global.dart';
import 'package:my_plants/Utils/bloc/bloc.dart';

class NavigationBar extends StatefulWidget {
  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> moveY;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    moveY = Tween(begin: 10.0, end: 70.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.35, curve: Curves.easeInOutBack)));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        if (!state.show) {
          animationController.reset();
          animationController.forward();
        } else {
          animationController.reverse();
        }

        return AnimatedBuilder(
          animation: animationController,
          builder: (_, widget) => Transform.translate(
            offset: Offset(0, moveY.value),
            child: Container(
              height: size.width * 0.18,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ItemsNavigationBar(
                      icon: buttonsNavigation["home"]!,
                      route: "home",
                      name: "Menu"),
                  Container(
                    width: 30,
                  ),
                  _ItemsNavigationBar(
                    icon: buttonsNavigation["recent"]!,
                    route: "recent",
                    textAlignLeft: true,
                    name: "Recientes",
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                  color: Color(0xff008F39),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(50))),
            ),
          ),
        );
      },
    );
  }
}

class _ItemsNavigationBar extends StatefulWidget {
  final String icon;
  final String route;
  final String name;
  final bool textAlignLeft;

  const _ItemsNavigationBar(
      {required this.icon,
      required this.route,
      required this.name,
      this.textAlignLeft = false});

  @override
  State<_ItemsNavigationBar> createState() => _ItemsNavigationBarState();
}

class _ItemsNavigationBarState extends State<_ItemsNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    scale = Tween(begin: 25.0, end: 35.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.3, curve: Curves.easeInOutBack)));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        final active = state.route == widget.route;
        if (active) {
          animationController.forward();
        } else {
          animationController.reset();
        }
        return GestureDetector(
          onTap: () {
            final changeRouteBloc =
                BlocProvider.of<NavigationBarBloc>(context, listen: false);

            changeRouteBloc.add(ChangeRouteNavigateEvent(route: widget.route));
          },
          child: Container(
            height: size.height * 0.05,
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.015),
            decoration: (active)
                ? BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 0.05)),
                    color: Colors.green[600])
                : const BoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                active && widget.textAlignLeft
                    ? Container(
                        margin: EdgeInsets.only(right: size.width * 0.02),
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (_, child) => SizedBox(
                    height: active ? scale.value : 30,
                    width: active ? scale.value : 30,
                    child: SvgPicture.asset(
                      widget.icon,
                      color: active ? Colors.white : Colors.white70,
                    ),
                  ),
                ),
                active && !widget.textAlignLeft
                    ? Container(
                        margin: EdgeInsets.only(left: size.width * 0.02),
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
