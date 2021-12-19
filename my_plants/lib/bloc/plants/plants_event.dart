part of 'plants_bloc.dart';

@immutable
abstract class PlantsEvent {}

class GetPlanstEvent extends PlantsEvent {
  final List<Plant> plants;
  GetPlanstEvent(this.plants);
}
