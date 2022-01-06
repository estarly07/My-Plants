part of 'type_plants_bloc.dart';

@immutable
abstract class TypePlantsEvent {}

class GetAllPlantEvent extends TypePlantsEvent {
  GetAllPlantEvent();
}

class ShowCharacteristicEvent extends TypePlantsEvent {
  final String caracteristic;
  ShowCharacteristicEvent(this.caracteristic);
}
