part of 'type_plants_bloc.dart';

@immutable
abstract class TypesPlantsState {
  List<TypePlant> plants;
  TypePlant? selectPlant;
  final String caracteristic;
  TypesPlantsState(this.plants, this.selectPlant, this.caracteristic);
}

class PlantsInitial extends TypesPlantsState {
  PlantsInitial() : super([], null, "");
}

class GetPlantsState extends TypesPlantsState {
  List<TypePlant> plants;
  GetPlantsState({required this.plants}) : super(plants, null, "");
}

class SelectPlantState extends TypesPlantsState {
  final TypePlant selectPlant;
  SelectPlantState(List<TypePlant> plants, this.selectPlant)
      : super(plants, selectPlant, "");
}

class ShowCharacteristicState extends TypesPlantsState {
  final String caracteristic;
  ShowCharacteristicState(
      List<TypePlant> plants, TypePlant selectPlant, this.caracteristic)
      : super(plants, selectPlant, caracteristic);
}
