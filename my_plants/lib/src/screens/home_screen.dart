import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_plants/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _NavigationBar(),
        ],
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({
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
