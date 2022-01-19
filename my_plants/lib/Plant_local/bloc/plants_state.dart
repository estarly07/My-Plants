part of 'plants_bloc.dart';

@immutable
abstract class PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsSearched;
  final List<Plant> plantsRecents;
  final List<Plant> plantsFavorites;
  final List<int> idPlantsSelects;
  PlantsState(this.plants, this.plantsRecents, this.idPlantsSelects,
      this.plantsFavorites, this.plantsSearched);
}

class PlantsInitial extends PlantsState {
  PlantsInitial() : super([], [], [], [], []);
}

class GetPlantsLocalState extends PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  final List<Plant> plantsSearched;
  GetPlantsLocalState(
      {required this.plantsSearched,
      required this.plants,
      required this.plantsRecents})
      : super(plants, plantsRecents, [], [], plantsSearched);
}

class SelectPlantsState extends PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  final List<int> idPlantsSelects;
  SelectPlantsState(
      {required this.plants,
      required this.plantsRecents,
      required this.idPlantsSelects})
      : super(plants, plantsRecents, idPlantsSelects, [], []);
}

class GetFavoritesPlantsState extends PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  final List<Plant> plantsFavorites;
  final List<int> idPlantsSelects;
  GetFavoritesPlantsState(
      {required this.plants,
      required this.plantsFavorites,
      required this.plantsRecents,
      required this.idPlantsSelects})
      : super(plants, plantsRecents, idPlantsSelects, plantsFavorites, []);
}

class SearchPlantsState extends PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  final List<Plant> searchPlants;
  final List<Plant> plantsFavorites;
  final List<int> idPlantsSelects;
  SearchPlantsState(
      {required this.plants,
      required this.searchPlants,
      required this.plantsFavorites,
      required this.plantsRecents,
      required this.idPlantsSelects})
      : super(plants, plantsRecents, idPlantsSelects, plantsFavorites,
            searchPlants);
}
