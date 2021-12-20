part of 'plants_bloc.dart';

@immutable
abstract class PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  PlantsState(this.plants, this.plantsRecents);
}

class PlantsInitial extends PlantsState {
  PlantsInitial() : super([], []);
}

class GetPlantsLocalState extends PlantsState {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  GetPlantsLocalState({required this.plants, required this.plantsRecents})
      : super(plants, plantsRecents);
}
