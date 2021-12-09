part of 'plants_bloc.dart';

@immutable
abstract class PlantsEvent {}

class GetAllPlantEvent extends PlantsEvent {
  List<Plant> plants;

  GetAllPlantEvent({required this.plants});
}
