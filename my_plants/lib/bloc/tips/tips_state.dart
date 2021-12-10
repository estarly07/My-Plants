part of 'tips_bloc.dart';

@immutable
abstract class TipsState {
  final List<Tip> tips;
  final Tip? tipRandom;

  TipsState(this.tips, this.tipRandom);
}

class TipsInitial extends TipsState {
  TipsInitial() : super([], null);
}

class ResponseTipsState extends TipsState {
  ResponseTipsState({required List<Tip> tips}) : super(tips, null);
}

class GenerateTipRandomState extends TipsState {
  GenerateTipRandomState({required List<Tip> tips, required Tip tipRandom})
      : super(tips, tipRandom);
}
