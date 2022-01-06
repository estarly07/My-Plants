import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_plants/Game/ui/widgets/game_match.dart';
import 'package:my_plants/Utils/values/global.dart';
import 'package:my_plants/Utils/bloc/bloc.dart';
import 'package:my_plants/Game/model/card_game.dart';
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
    provider = BlocProvider.of<GameBloc>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                            SafeArea(child: Hearts()),
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
}
