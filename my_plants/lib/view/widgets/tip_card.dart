import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TipCard extends StatelessWidget {
  const TipCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.07, left: 10, right: 10),
      decoration: _cardDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: Color(0xffFFCF53),
          child: Stack(
            children: [
              Positioned(right: -40, top: -20, child: _tipDecoration()),
              _tip(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
            blurRadius: 10,
            spreadRadius: -2,
            offset: Offset(1, 5),
            color: Colors.black54.withOpacity(0.5))
      ],
    );
  }

  Widget _tipDecoration() {
    return const Opacity(
      opacity: 0.7,
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/tip_decoration.png"),
      ),
    );
  }

  Container _tip() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          _Icon_tip(),
          Expanded(
            child: Container(
              child: ListTile(
                title: _title(),
                subtitle: _content(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _title() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        "Title",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  Text _content() {
    return Text(
      "sssssssssssssssssssssssssssssssssss sssssssssssssssssssssss sssssssssssssssssssssss sssssssssssssssssss ssssssssss sssssssssssssss asdasd asdasd as dasdfer as aweaw asdasdasd a",
      style: TextStyle(fontSize: 13, height: 1.2),
      textAlign: TextAlign.start,
    );
  }
}

class _Icon_tip extends StatelessWidget {
  const _Icon_tip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.all(5),
        width: size.width * 0.22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeData.light().scaffoldBackgroundColor,
        ),
        child: SvgPicture.asset(
          "assets/images/svg/wait_plant.svg",
          width: 40,
          height: 40,
        ));
  }
}
