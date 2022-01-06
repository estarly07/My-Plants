import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_plants/Game/model/card_game.dart';
import 'package:my_plants/Utils/values/global.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

class CardGame extends StatelessWidget {
  final CardGameModel card;
  const CardGame({
    required this.card,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.03),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: Background(
                    (card.visible) ? colors[1]! : Colors.grey.withOpacity(0.5)),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: size.width * 0.3,
                height: size.height * 0.17,
                child: (!card.visible)
                    ? Image(image: AssetImage("assets/images/wait_plant.png"))
                    : FadeInImage(
                        placeholder: AssetImage("assets/images/wait_plant.png"),
                        image: NetworkImage(card.photo)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
