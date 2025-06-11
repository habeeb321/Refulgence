part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadProductsEvent extends HomeEvent {}

class SearchProductsEvent extends HomeEvent {
  final String query;

  SearchProductsEvent(this.query);

  @override
  List<Object> get props => [query];
}
