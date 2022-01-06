import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/Plant_local/model/plant_local.dart';
import 'package:my_plants/Plant_local/repository/services/database_service.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  DataBaseService dataBaseService = DataBaseService();

  PlantsBloc() : super(PlantsInitial()) {
    on<GetPlanstEvent>((event, emit) async {
      List<Plant> allPlants = await dataBaseService.getAllPlants();
      List<Plant> plantsRecents = await dataBaseService.getRecentsPlants();
      emit(
          GetPlantsLocalState(plants: allPlants, plantsRecents: plantsRecents));
    });

    on<SelectPlanstEvent>((event, emit) => {
          emit(SelectPlantsState(
              plants: state.plants,
              plantsRecents: state.plantsRecents,
              idPlantsSelects: _selectPlant(event.idPlant)))
        });
  }
  List<int> idsPlantsSelect = [];
  List<int> _selectPlant(int idPlant) {
    if (idsPlantsSelect.isEmpty) {
      idsPlantsSelect.add(idPlant);
    } else {
      bool isDuplicate = false;
      for (var id in idsPlantsSelect) {
        if (id == idPlant) {
          isDuplicate = true;
        }
      }
      if (isDuplicate) {
        idsPlantsSelect.remove(idPlant);
      } else {
        idsPlantsSelect.add(idPlant);
      }
    }
    return idsPlantsSelect;
  }
}
