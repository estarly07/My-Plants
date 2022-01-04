part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameStartEvent extends GameEvent {
  final bool initGame;
  final List<CardGameModel> plants;
  final String screen;
  GameStartEvent(this.initGame, this.plants, this.screen);
}

class GameSelectedPlantEvent extends GameEvent {
  final List<CardGameModel> cardsSelect;
  final List<CardGameModel> plants;
  final int fails;
  final int corrects;
  GameSelectedPlantEvent(
      this.cardsSelect, this.plants, this.fails, this.corrects);
}
