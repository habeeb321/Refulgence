part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {}

final class NavigationSelected extends NavigationState {
  final NavigationTab selectedTab;
  NavigationSelected(this.selectedTab);
}
