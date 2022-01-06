import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_plants/Utils/services/services.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

class MenuGame extends StatelessWidget {
  MenuGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Preferences _preferences = Preferences();
    return Center(
      child: Stack(
        children: [
          BackgrounScreenCustom(),
          SafeArea(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.05,
                      top: size.height * 0.05,
                      left: size.height * 0.01),
                  child: Text(
                    "Busca las plantas!!",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Midnight"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.05, left: size.height * 0.01),
                  child: Text(
                    "Encuentra las parejas para ganar\nBuena suerte 😊",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    stadistic(
                        "Juegos",
                        "${_preferences.games}",
                        size.width * 0.1,
                        size.width * 0.1,
                        "assets/images/svg/match.svg",
                        size),
                    stadistic(
                        "Ganados",
                        "${_preferences.wins}",
                        size.width * 0.1,
                        size.width * 0.1,
                        "assets/images/svg/win.svg",
                        size),
                    stadistic(
                        "Perdidas",
                        "${_preferences.fails}",
                        size.width * 0.1,
                        size.width * 0.1,
                        "assets/images/svg/lose.svg",
                        size),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.05,
                      top: size.height * 0.05,
                      left: size.height * 0.01),
                  child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CardLevelGame(
                          cantCards: 4,
                          title: "Fácil",
                          image: "assets/images/easy.png",
                        ),
                        CardLevelGame(
                          cantCards: 5,
                          title: "Medio",
                          image: "assets/images/medio.png",
                        ),
                      ],
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: (size.width * 0.5),
                          mainAxisExtent: (size.height * 0.24),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column stadistic(String title, String score, double height, double width,
      String image, Size textSize) {
    return Column(
      children: [
        SvgPicture.asset(
          image,
          height: height,
          width: width,
        ),
        Text(
          title,
          style: TextStyle(fontSize: textSize.width * 0.04, color: Colors.grey),
        ),
        Text(
          score,
          style: TextStyle(
              fontSize: textSize.width * 0.06, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
