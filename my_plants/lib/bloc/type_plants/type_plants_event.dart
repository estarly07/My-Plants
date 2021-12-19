part of 'type_plants_bloc.dart';

@immutable
abstract class PlantsEvent {}

class GetAllPlantEvent extends PlantsEvent {
  List<TypePlant> plants;

  GetAllPlantEvent({required this.plants});
}

class SelectPlantEvent extends PlantsEvent {
  TypePlant? selectPlant;
  SelectPlantEvent(this.selectPlant);
}

class ShowCharacteristicEvent extends PlantsEvent {
  final String caracteristic;
  ShowCharacteristicEvent(this.caracteristic);
}
