import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_plants/Utils/values/global.dart';
import 'package:my_plants/Utils/bloc/bloc.dart';
import 'package:my_plants/Game/model/card_game.dart';
import 'package:my_plants/Type_plant/model/type_plant.dart';
import 'package:my_plants/Type_plant/repository/services/plants_service.dart';
import 'package:my_plants/Utils/services/services.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

class Game extends StatefulWidget {
  Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool showAnimation = false;
  String animation = "";
  Timer? _timer;

  late final provider;
  @override
  void initState() {
    // TODO: implement initState
    provider = BlocProvider.of<GameBloc>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneDecimal = Duration(seconds: 2);
    _timer = Timer.periodic(
        oneDecimal,
        (Timer timer) => setState(() {
              provider.add(GameStartEvent(false, [], "menu"));
              showAnimation = false;
              _timer?.cancel();
            }));
  }

  @override
  Widget build(BuildContext context) {
    final Preferences _preferences = Preferences();
    final size = MediaQuery.of(context).size;
    provider.add(GameStartEvent(false, [], "menu"));

    return Scaffold(
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          print("VIDAS ${state.fails}");
          if (provider.state.fails == 3 && provider.state.initGame) {
            _preferences.setGames();
            _preferences.setFails();
            showAnimation = true;
            animation = "assets/animations/unlike.json";
          }
          if (provider.state.initGame &&
              provider.state.corrects == (provider.state.cards.length / 2)) {
            _preferences.setGames();
            _preferences.setWins();
            showAnimation = true;
            animation = "assets/animations/win.json";
          }
          if (showAnimation) {
            startTimer();
          }

          return (state.screen == "menu")
              ? MenuGame()
              : Stack(
                  children: [
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SafeArea(child: _Hearts()),
                            Center(
                                child:
                                    GameMatch(cards: state.cards, size: size)),
                          ],
                        ),
                      ),
                    ),
                    (showAnimation)
                        ? Container(
                            width: size.height,
                            child: Center(
                                child: Lottie.asset(animation, repeat: false)),
                          )
                        : Container(),
                  ],
                );
        },
      ),
    );
  }
}

class _Hearts extends StatelessWidget {
  const _Hearts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = BlocProvider.of<GameBloc>(context);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.height * 0.025),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _heart(provider.state.fails >= 1, size.width * 0.12),
          _heart(provider.state.fails >= 2, size.width * 0.12),
          _heart(provider.state.fails >= 3, size.width * 0.12),
        ],
      ),
    );
  }

  Widget _heart(bool lose, double size) => Lottie.asset(
        "assets/animations/unlove.json",
        height: size * 2,
        width: size * 2,
        repeat: false,
        animate: lose,
      );
}

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

class CardLevelGame extends StatelessWidget {
  final int cantCards;
  final String title;
  final String image;
  const CardLevelGame({
    required this.cantCards,
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => generatePlants(context, cantCards),
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.02),
        height: size.height * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.02),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 15,
                  color: Colors.black54,
                  spreadRadius: -5,
                  offset: Offset(5, 5))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(image),
              height: size.height * 0.15,
              width: size.height * 0.15,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  void generatePlants(BuildContext context, int cantCards) {
    final typesPlants = TypesPlantServices.allTypePlants;
    List<TypePlant> plants = [];
    for (var i = 0; i < cantCards; i++) {
      plants.add(typesPlants[i]);
    }

    List<int> indexWithDuo = []; //indices que ya salieron 2 veces
    List<TypePlant> plantsSort = [];
    for (var i = 0; i < (plants.length * 2); i++) {
      int indexRandom = Random().nextInt(plants.length);
      if (plantsSort.isEmpty) {
        plantsSort.add(plants[indexRandom]);
      } else {
        if (plantsSort.contains(plants[indexRandom])) {
          if (indexWithDuo.isEmpty || !indexWithDuo.contains(indexRandom)) {
            plantsSort.add(plants[indexRandom]);
            indexWithDuo.add(indexRandom);
          } else {
            i--;
          }
        } else {
          plantsSort.add(plants[indexRandom]);
        }
      }
    }
    List<CardGameModel> cards = [];
    for (var i = 0; i < plantsSort.length; i++) {
      cards.add(CardGameModel(
          index: i,
          photo: plantsSort[i].picture,
          name: plantsSort[i].name,
          visible: true));
    }

    BlocProvider.of<GameBloc>(context, listen: false)
        .add(GameStartEvent(false, cards, "game"));
  }
}

class GameMatch extends StatefulWidget {
  final List<CardGameModel> cards;
  GameMatch({
    required this.cards,
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<GameMatch> createState() => _GameMatchState();
}

class _GameMatchState extends State<GameMatch> {
  List<CardGameModel> cardSelect = [];

  Timer? _timer;
  void showAllCard() {
    print("object");
    final provider = BlocProvider.of<GameBloc>(context, listen: false);
    print(provider.state.initGame);
    final cards = provider.state.cards;
    cards.forEach((element) {
      element.visible = false;
    });
    provider.add(GameStartEvent(true, cards, "game"));
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    if (_timerSelectionCard != null) {
      _timerSelectionCard!.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<GameBloc>(context, listen: false);
    final size = MediaQuery.of(context).size;
    /*   if (!provider.state.initGame) {
      startTimer();
    } */

    if (provider.state.cardsSelected.length == 2) {
      if (cardSelect[0].name == cardSelect[1].name) {
        cardSelect = [];
        provider.add(GameSelectedPlantEvent(cardSelect, provider.state.cards,
            provider.state.fails, provider.state.corrects + 1));
      } else {
        incorrectCardsTimer();
      }
    }

    return Stack(
      children: [
        Container(
          child: GridView(
              shrinkWrap: true,
              children: widget.cards
                  .map((e) => GestureDetector(
                        onTap: () {
                          if (cardSelect.length != 2) {
                            print(e.index);
                            if (cardSelect.length == 1) {
                              //in case it touches the same card
                              if (cardSelect[0].index != e.index) {
                                cardSelect.add(e);
                                widget.cards
                                    .elementAt(widget.cards.indexOf(e))
                                    .visible = true;
                                provider.add(GameSelectedPlantEvent(
                                    cardSelect,
                                    widget.cards,
                                    provider.state.fails,
                                    provider.state.corrects));
                              }
                            } else {
                              cardSelect.add(e);
                              widget.cards
                                  .elementAt(widget.cards.indexOf(e))
                                  .visible = true;
                              provider.add(GameSelectedPlantEvent(
                                  cardSelect,
                                  widget.cards,
                                  provider.state.fails,
                                  provider.state.corrects));
                            }
                          }
                        },
                        child: CardGame(
                          card: e,
                        ),
                      ))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: (widget.size.width * 0.4),
                  mainAxisExtent: (widget.size.height * 0.2),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10)),
        ),
        provider.state.initGame
            ? Container()
            : SizedBox(
                height: size.height * 0.8,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      showAllCard();
                    },
                    child: Container(
                      height: size.width * 0.2,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[600],
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                color: Colors.black54,
                                spreadRadius: 0)
                          ]),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: size.height * 0.03,
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }

  void startTimer() {
    const oneDecimal = Duration(seconds: 3);
    _timer = Timer.periodic(
        oneDecimal,
        (Timer timer) => setState(() {
              showAllCard();
            }));
  }

  Timer? _timerSelectionCard = null;
  void incorrectCardsTimer() {
    const oneDecimal = Duration(milliseconds: 1300);
    _timerSelectionCard = Timer.periodic(
        oneDecimal,
        (Timer timer) => setState(() {
              incorrectCards();
            }));
  }

  void incorrectCards() {
    final provider = BlocProvider.of<GameBloc>(context, listen: false);
    for (var e in cardSelect) {
      widget.cards.elementAt(widget.cards.indexOf(e)).visible = false;
    }
    cardSelect = [];
    provider.add(GameSelectedPlantEvent(cardSelect, provider.state.cards,
        provider.state.fails + 1, provider.state.corrects));
    _timerSelectionCard!.cancel();
  }
}

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

class Background extends CustomPainter {
  Color color;
  Background(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.3);
    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.9,
        size.height * 0.05,
        //--------PUNTO FINAL
        size.width * 0.5,
        size.height * 0.28);
    path.lineTo(size.width * 0.1, size.height * 0.5);

    path.quadraticBezierTo(
        //-----------PUNTO DEL eje de la curbatura-
        size.width * 0.005,
        size.height * 0.55,
        //--------PUNTO FINAL
        0,
        size.height * 0.6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
