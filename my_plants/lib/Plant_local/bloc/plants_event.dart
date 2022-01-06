part of 'plants_bloc.dart';

@immutable
abstract class PlantsEvent {}

class GetPlanstEvent extends PlantsEvent {
  GetPlanstEvent();
}

class SelectPlanstEvent extends PlantsEvent {
  int idPlant;
  SelectPlanstEvent(this.idPlant);
}
