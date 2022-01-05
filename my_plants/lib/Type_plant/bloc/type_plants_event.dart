part of 'type_plants_bloc.dart';

@immutable
abstract class TypePlantsEvent {}

class GetAllPlantEvent extends TypePlantsEvent {
  List<TypePlant> plants;

  GetAllPlantEvent({required this.plants});
}

class ShowCharacteristicEvent extends TypePlantsEvent {
  final String caracteristic;
  ShowCharacteristicEvent(this.caracteristic);
}
