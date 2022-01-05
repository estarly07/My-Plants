part of 'navigation_bar_bloc.dart';

@immutable
abstract class NavigationBarState {
  final bool show;
  final String route;
  NavigationBarState({this.show = true, required this.route});
}

class NavigationBarInitial extends NavigationBarState {
  NavigationBarInitial() : super(show: true, route: "home");
}

class ShowNavigatorState extends NavigationBarState {
  ShowNavigatorState({required bool show, required String route})
      : super(show: show, route: route);
}

class ChangeRouteNavigateState extends NavigationBarState {
  final String route;

  ChangeRouteNavigateState({required this.route}) : super(route: route);
}
