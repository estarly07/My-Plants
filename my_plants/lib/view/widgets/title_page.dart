import 'package:flutter/cupertino.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "Tus plantas",
        style: const TextStyle(
            fontSize: 35,
            fontFamily: "HungryCharlie",
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2),
      ),
    );
  }
}
