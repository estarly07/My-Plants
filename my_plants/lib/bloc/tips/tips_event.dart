part of 'tips_bloc.dart';

@immutable
abstract class TipsEvent {}

class ResponseTipsEvent extends TipsEvent {
  List<Tip> tips;
  ResponseTipsEvent({required this.tips});
}

class GenerateTipRandomEvent extends TipsEvent {
  Tip tipRandom;
  GenerateTipRandomEvent({required this.tipRandom});
}
