import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  NavigationBarBloc() : super(NavigationBarInitial()) {
    on<ShowNavigationBarEvent>((event, emit) {
      emit(ShowNavigatorState(show: event.show));
    });
  }
}
