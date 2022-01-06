import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/Tip/model/tip.dart';
import 'package:my_plants/Tip/repository/services/tips_service.dart';

part 'tips_event.dart';
part 'tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  TipsService tipServices = TipsService();
  TipsBloc() : super(TipsInitial()) {
    on<GetTipsEvent>((event, emit) async {
      emit(ResponseTipsState(tips: await tipServices.getTips()));
      add(GenerateTipRandomEvent());
    });
    on<GenerateTipRandomEvent>((event, emit) {
      if (state.tipRandom == null) {
        emit(GenerateTipRandomState(
            tips: state.tips, tipRandom: tipRandom(state.tips)));
      }
    });
  }
  Tip tipRandom(List<Tip> allTips) => allTips[Random().nextInt(allTips.length)];
}
