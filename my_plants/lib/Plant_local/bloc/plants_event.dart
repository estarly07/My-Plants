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

class SavedPlantEvent extends PlantsEvent {
  final bool saved;
  final int idPlant;
  SavedPlantEvent(this.saved, this.idPlant);
}

class DeletePlantEvent extends PlantsEvent {
  final BuildContext context;
  DeletePlantEvent(this.context);
}

class GetPlantsFavoritesEvent extends PlantsEvent {
  GetPlantsFavoritesEvent();
}
