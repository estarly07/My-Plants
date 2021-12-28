part of 'plants_bloc.dart';

@immutable
abstract class PlantsEvent {}

class GetPlanstEvent extends PlantsEvent {
  final List<Plant> plants;
  final List<Plant> plantsRecents;
  GetPlanstEvent(this.plants, this.plantsRecents);
}

class SelectPlanstEvent extends PlantsEvent {
  final List<int> idPlantsSelects;
  SelectPlanstEvent(this.idPlantsSelects);
}
