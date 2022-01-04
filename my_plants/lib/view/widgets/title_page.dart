import 'package:flutter/cupertino.dart';

class TitlePage extends StatelessWidget {
  final String title;
  const TitlePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
            fontFamily: "Ice"),
      ),
    );
  }
}
