import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/models/plant.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  PlantsBloc() : super(PlantsInitial()) {
    on<GetAllPlantEvent>((event, emit) {
      emit(GetPlantsState(plants: event.plants));
    });
    on<SelectPlantEvent>((event, emit) =>
        {emit(SelectPlantState(state.plants, event.selectPlant!))});
    on<ShowCharacteristicEvent>((event, emit) => {
          emit(ShowCharacteristicState(
              state.plants, state.selectPlant!, event.caracteristic))
        });
  }
}
