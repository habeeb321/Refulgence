part of 'detail_bloc.dart';

@immutable
sealed class DetailEvent {}

class LoadCommentsEvent extends DetailEvent {
  final ProductsModel product;
  final int postId;

  LoadCommentsEvent({
    required this.product,
    required this.postId,
  });
}