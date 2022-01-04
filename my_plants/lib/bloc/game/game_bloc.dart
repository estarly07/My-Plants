import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/models/card_game.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GameStartEvent>((event, emit) {
      emit(GamePlantsStartState(
          initGame: event.initGame, cards: event.plants, screen: event.screen));
    });
    on<GameSelectedPlantEvent>((event, emit) {
      emit(GameSelectedPlantState(
          cardsSelected: event.cardsSelect,
          initGame: state.initGame,
          fails: event.fails,
          corrects: event.corrects,
          cards: event.plants));
    });
  }
}
