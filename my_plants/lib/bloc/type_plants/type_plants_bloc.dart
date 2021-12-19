import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/models/type_plant.dart';

part 'type_plants_event.dart';
part 'type_plants_state.dart';

class TypesPlantsBloc extends Bloc<PlantsEvent, TypesPlantsState> {
  TypesPlantsBloc() : super(PlantsInitial()) {
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
