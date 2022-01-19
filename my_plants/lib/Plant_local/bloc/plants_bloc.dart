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
      emit(GetPlantsLocalState(
          plants: allPlants,
          plantsRecents: plantsRecents,
          plantsSearched: state.plantsSearched));
    });

    on<SelectPlanstEvent>((event, emit) => {
          emit(SelectPlantsState(
              plants: state.plants,
              plantsRecents: state.plantsRecents,
              idPlantsSelects: _selectPlant(event.idPlant)))
        });

    on<DeletePlantEvent>((event, emit) {
      final plants = state.plants;
      final plantsRecents = state.plantsRecents;
      dataBaseService.deletePlantsSelected(
          context: event.context, idsPlants: state.idPlantsSelects);

      state.idPlantsSelects.forEach((idPlant) {
        final plant =
            plants.firstWhere((element) => element.idPlant == idPlant);
        if (plants.contains(plant)) {
          plants.remove(plant);
        }

        if (plantsRecents.contains(plant)) {
          plantsRecents.remove(plant);
        }
      });

      emit(GetPlantsLocalState(
        plantsSearched: state.plantsSearched,
        plants: plants,
        plantsRecents: plantsRecents,
      ));
    });
    on<GetPlantsFavoritesEvent>((event, emit) async {
      emit(GetFavoritesPlantsState(
          plants: state.plants,
          plantsFavorites: await dataBaseService.getFavoritesPlants(),
          plantsRecents: state.plantsRecents,
          idPlantsSelects: state.idPlantsSelects));
    });
    on<SearchPlantsEvent>((event, emit) async {
      emit(SearchPlantsState(
          plants: state.plants,
          plantsFavorites: state.plantsFavorites,
          plantsRecents: state.plantsRecents,
          idPlantsSelects: state.idPlantsSelects,
          searchPlants: await dataBaseService.searchPlants(event.name)));
    });

    on<SavedPlantEvent>((event, emit) {
      List<Plant> plants = state.plants;
      List<Plant> plantsRecents = state.plantsRecents;

      print(event.idPlant);

      final plant =
          plants.firstWhere((element) => element.idPlant == event.idPlant);
      if (plantsRecents.contains(plant)) {
        plant.saved = event.saved;
        final index = plantsRecents.indexOf(plant);
        plantsRecents.removeAt(index);
        plantsRecents.insert(index, plant);
      }

      final index = plants.indexOf(plant);
      plant.saved = event.saved;
      plants.removeAt(index);
      plants.insert(index, plant);

      dataBaseService.plantSaved(event.saved, event.idPlant);
      emit(GetPlantsLocalState(
        plantsSearched: state.plantsSearched,
        plants: plants,
        plantsRecents: plantsRecents,
      ));
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
