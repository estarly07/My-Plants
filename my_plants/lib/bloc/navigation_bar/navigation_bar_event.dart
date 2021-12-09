part of 'navigation_bar_bloc.dart';

@immutable
abstract class NavigationBarEvent {}

class ShowNavigationBarEvent extends NavigationBarEvent {
  bool show;
  ShowNavigationBarEvent({this.show = true});
}
