import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/models/tip.dart';

part 'tips_event.dart';
part 'tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  TipsBloc() : super(TipsInitial()) {
    on<ResponseTipsEvent>((event, emit) {
      emit(ResponseTipsState(tips: event.tips));
    });
    on<GenerateTipRandomEvent>((event, emit) => {
          emit(GenerateTipRandomState(
              tips: state.tips, tipRandom: event.tipRandom))
        });
  }
}
