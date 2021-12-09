import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/bloc/navigation_bar/navigation_bar_bloc.dart';

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
    // TODO: implement dispose
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
                  _ItemsNavigationBar(icon: Icons.home, route: "home"),
                  _ItemsNavigationBar(
                      icon: Icons.favorite_outline_rounded, route: "likes"),
                  _ItemsNavigationBar(icon: Icons.read_more, route: "all"),
                  _ItemsNavigationBar(icon: Icons.person, route: ""),
                ],
              ),
              decoration: const BoxDecoration(
                  //32CD32
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
  final IconData icon;
  final String route;

  const _ItemsNavigationBar({required this.icon, required this.route});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animationController,
                builder: (_, child) => Icon(
                  widget.icon,
                  size: active ? scale.value : 30,
                  color: active ? Colors.white : Colors.white70,
                ),
              ),
              Container(
                margin: EdgeInsets.all(3),
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: active ? Colors.white : Color(0xff008F39)),
              ),
            ],
          ),
        );
      },
    );
  }
}
