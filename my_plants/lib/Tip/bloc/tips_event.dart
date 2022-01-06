part of 'tips_bloc.dart';

@immutable
abstract class TipsEvent {}

class GetTipsEvent extends TipsEvent {
  GetTipsEvent();
}

class GenerateTipRandomEvent extends TipsEvent {
  GenerateTipRandomEvent();
}
