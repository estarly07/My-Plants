import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.width * 0.18,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ItemsNavigationBar(icon: Icons.home),
          _ItemsNavigationBar(icon: Icons.favorite_outline_rounded),
          _ItemsNavigationBar(icon: Icons.read_more),
          _ItemsNavigationBar(icon: Icons.person),
        ],
      ),
      decoration: const BoxDecoration(
          //32CD32
          color: Color(0xff008F39),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(50))),
    );
  }
}

class _ItemsNavigationBar extends StatelessWidget {
  final IconData icon;

  const _ItemsNavigationBar({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
        Container(
          margin: EdgeInsets.all(3),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.white),
        ),
      ],
    );
  }
}
