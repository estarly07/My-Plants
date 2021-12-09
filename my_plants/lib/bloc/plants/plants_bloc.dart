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
  }
}
