import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/Type_plant/model/type_plant.dart';
import 'package:my_plants/Type_plant/repository/services/plants_service.dart';

part 'type_plants_event.dart';
part 'type_plants_state.dart';

class TypesPlantsBloc extends Bloc<TypePlantsEvent, TypesPlantsState> {
  TypesPlantServices typePlantsService = TypesPlantServices();

  TypesPlantsBloc() : super(TypePlantsInitial()) {
    on<GetAllPlantEvent>((event, emit) async {
      emit(GetPlantsState(plants: await typePlantsService.getAllPlants()));
    });

    on<ShowCharacteristicEvent>((event, emit) =>
        {emit(ShowCharacteristicState(state.plants, event.caracteristic))});
  }
}
