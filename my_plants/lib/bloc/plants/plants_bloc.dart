import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/models/plant_local.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  PlantsBloc() : super(PlantsInitial()) {
    on<GetPlanstEvent>((event, emit) {
      emit(GetPlantsLocalState(
          plants: event.plants, plantsRecents: event.plantsRecents));
    });

    on<SelectPlanstEvent>((event, emit) => {
          emit(SelectPlantsState(
              plants: state.plants,
              plantsRecents: state.plantsRecents,
              idPlantsSelects: event.idPlantsSelects))
        });
  }
}
