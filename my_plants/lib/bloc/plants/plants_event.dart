part of 'plants_bloc.dart';

@immutable
abstract class PlantsEvent {}

class GetAllPlantEvent extends PlantsEvent {
  List<Plant> plants;

  GetAllPlantEvent({required this.plants});
}

class SelectPlantEvent extends PlantsEvent {
  Plant? selectPlant;
  SelectPlantEvent(this.selectPlant);
}

class ShowCharacteristicEvent extends PlantsEvent {
  final String caracteristic;
  ShowCharacteristicEvent(this.caracteristic);
}
