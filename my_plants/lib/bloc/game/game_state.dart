part of 'game_bloc.dart';

@immutable
abstract class GameState {
  final bool initGame;
  final List<CardGameModel> cards;
  final List<CardGameModel> cardsSelected;
  final String screen;
  final int fails;
  final int corrects;
  GameState(
      {required this.initGame,
      required this.cards,
      required this.fails,
      required this.corrects,
      required this.screen,
      required this.cardsSelected});
}

class GameInitial extends GameState {
  GameInitial()
      : super(
            cardsSelected: [],
            screen: "menu",
            initGame: false,
            cards: [],
            fails: 0,
            corrects: 0);
}

class GamePlantsStartState extends GameState {
  final bool initGame;
  final List<CardGameModel> cards;
  final String screen;
  GamePlantsStartState(
      {required this.screen, required this.initGame, required this.cards})
      : super(
            cardsSelected: [],
            screen: screen,
            initGame: true,
            cards: cards,
            fails: 0,
            corrects: 0);
}

class GameSelectedPlantState extends GameState {
  final bool initGame;
  final List<CardGameModel> cards;
  final List<CardGameModel> cardsSelected;
  final int fails;
  final int corrects;
  GameSelectedPlantState({
    required this.initGame,
    required this.cardsSelected,
    required this.fails,
    required this.corrects,
    required this.cards,
  }) : super(
          cardsSelected: cardsSelected,
          screen: "game",
          corrects: corrects,
          fails: fails,
          initGame: true,
          cards: cards,
        );
}
