part of 'detail_bloc.dart';

@immutable
sealed class DetailState {}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailLoaded extends DetailState {
  final ProductsModel product;
  final List<CommentsModel> comments;

  DetailLoaded({
    required this.product,
    required this.comments,
  });
}

final class DetailError extends DetailState {
  final String message;

  DetailError({required this.message});
}
