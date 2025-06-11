part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductsModel>? products;

  HomeLoaded({required this.products});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
