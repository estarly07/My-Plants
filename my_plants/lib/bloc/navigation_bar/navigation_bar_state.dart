part of 'navigation_bar_bloc.dart';

@immutable
abstract class NavigationBarState {
  final bool show;

  NavigationBarState({required this.show});
}

class NavigationBarInitial extends NavigationBarState {
  NavigationBarInitial() : super(show: true);
}

class ShowNavigatorState extends NavigationBarState {
  ShowNavigatorState({bool show = true}) : super(show: show);
}
