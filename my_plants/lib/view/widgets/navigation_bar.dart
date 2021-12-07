import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.width * 0.2,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ItemsNavigationBar(),
          _ItemsNavigationBar(),
          _ItemsNavigationBar(),
          _ItemsNavigationBar(),
        ],
      ),
      decoration: const BoxDecoration(
          //32CD32
          color: Color(0xff228B22),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
    );
  }
}

class _ItemsNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.white),
        ),
        Icon(
          Icons.home,
          size: 30,
          color: Colors.white,
        ),
      ],
    );
  }
}
