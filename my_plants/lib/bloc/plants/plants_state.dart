part of 'plants_bloc.dart';

@immutable
abstract class PlantsState {
  final List<Plant> plants;

  PlantsState(this.plants);
}

class PlantsInitial extends PlantsState {
  PlantsInitial() : super([]);
}

class GetPlantsState extends PlantsState {
  final List<Plant> plants;
  GetPlantsState({required this.plants}) : super(plants);
}
