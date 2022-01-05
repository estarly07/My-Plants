part of 'type_plants_bloc.dart';

@immutable
abstract class TypesPlantsState {
  List<TypePlant> plants;
  final String caracteristic;
  TypesPlantsState(this.plants, this.caracteristic);
}

class TypePlantsInitial extends TypesPlantsState {
  TypePlantsInitial() : super([], "");
}

class GetPlantsState extends TypesPlantsState {
  List<TypePlant> plants;
  GetPlantsState({required this.plants}) : super(plants, "");
}

class ShowCharacteristicState extends TypesPlantsState {
  final String caracteristic;
  ShowCharacteristicState(List<TypePlant> plants, this.caracteristic)
      : super(plants, caracteristic);
}
