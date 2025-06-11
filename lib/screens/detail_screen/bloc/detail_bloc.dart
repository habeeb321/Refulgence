import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refulgence/screens/detail_screen/model/comments_model.dart';
import 'package:refulgence/screens/detail_screen/service/detail_service.dart';
import 'package:refulgence/screens/home_screen/model/products_model.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<LoadCommentsEvent>(_onLoadComments);
  }

  Future<void> _onLoadComments(
    LoadCommentsEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(DetailLoading());

    try {
      final allComments = await DetailService.getComments();
      if (allComments != null) {
        final filteredComments = allComments
            .where((comment) => comment.postId == event.postId)
            .toList();

        emit(DetailLoaded(
          product: event.product,
          comments: filteredComments,
        ));
      } else {
        emit(DetailError(message: 'Failed to load comments'));
      }
    } catch (e) {
      emit(DetailError(message: 'Error: ${e.toString()}'));
    }
  }
}
