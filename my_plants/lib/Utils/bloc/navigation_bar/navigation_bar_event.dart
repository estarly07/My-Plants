part of 'navigation_bar_bloc.dart';

@immutable
abstract class NavigationBarEvent {}

class ShowNavigationBarEvent extends NavigationBarEvent {
  ShowNavigationBarEvent();
}

class ChangeRouteNavigateEvent extends NavigationBarEvent {
  String route;

  ChangeRouteNavigateEvent({required this.route});
}
