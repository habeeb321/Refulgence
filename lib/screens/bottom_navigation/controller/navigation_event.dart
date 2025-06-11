part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class TabSelectedEvent extends NavigationEvent {
  final NavigationTab tab;
  TabSelectedEvent(this.tab);
}