part of 'plants_bloc.dart';

@immutable
abstract class PlantsState {
  List<Plant> plants;
  Plant? selectPlant;
  final String caracteristic;
  PlantsState(this.plants, this.selectPlant, this.caracteristic);
}

class PlantsInitial extends PlantsState {
  PlantsInitial() : super([], null, "");
}

class GetPlantsState extends PlantsState {
  List<Plant> plants;
  GetPlantsState({required this.plants}) : super(plants, null, "");
}

class SelectPlantState extends PlantsState {
  final Plant selectPlant;
  SelectPlantState(List<Plant> plants, this.selectPlant)
      : super(plants, selectPlant, "");
}

class ShowCharacteristicState extends PlantsState {
  final String caracteristic;
  ShowCharacteristicState(
      List<Plant> plants, Plant selectPlant, this.caracteristic)
      : super(plants, selectPlant, caracteristic);
}
