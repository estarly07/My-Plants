import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/Game/bloc/game_bloc.dart';
import 'package:my_plants/Game/model/card_game.dart';
import 'package:my_plants/Utils/view/widgets/widgets.dart';

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
                        child: ElasticIn(
                          child: CardGame(
                            card: e,
                          ),
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
