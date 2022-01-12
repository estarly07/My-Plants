part of 'plants_bloc.dart';

@immutable
abstract class PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  final List<Plant> plantsFavorites;
  final List<int> idPlantsSelects;
  PlantsState(this.plants, this.plantsRecents, this.idPlantsSelects,
      this.plantsFavorites);
}

class PlantsInitial extends PlantsState {
  PlantsInitial() : super([], [], [], []);
}

class GetPlantsLocalState extends PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  GetPlantsLocalState({required this.plants, required this.plantsRecents})
      : super(plants, plantsRecents, [], []);
}

class SelectPlantsState extends PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  final List<int> idPlantsSelects;
  SelectPlantsState(
      {required this.plants,
      required this.plantsRecents,
      required this.idPlantsSelects})
      : super(plants, plantsRecents, idPlantsSelects, []);
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
      : super(plants, plantsRecents, idPlantsSelects, plantsFavorites);
}
