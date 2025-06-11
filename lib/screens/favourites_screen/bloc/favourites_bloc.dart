import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refulgence/screens/favourites_screen/bloc/favourites_event.dart';
import 'package:refulgence/screens/favourites_screen/bloc/favourites_state.dart';
import 'package:refulgence/screens/favourites_screen/repository/favourites_repository.dart';
import 'package:refulgence/screens/home_screen/model/products_model.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final FavouritesRepository _repository;

  FavouritesBloc(this._repository) : super(FavouritesInitial()) {
    on<LoadFavouritesEvent>(_onLoadFavourites);
    on<AddToFavouritesEvent>(_onAddToFavourites);
    on<RemoveFromFavouritesEvent>(_onRemoveFromFavourites);
    on<CheckIsFavouriteEvent>(_onCheckIsFavourite);
  }

  Future<void> _onLoadFavourites(
    LoadFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(FavouritesLoading());
    try {
      final favourites = await _repository.getFavourites();
      final favouriteStatus = <int, bool>{};

      for (final product in favourites) {
        favouriteStatus[product.id!] = true;
      }

      emit(FavouritesLoaded(
        favourites: favourites,
        favouriteStatus: favouriteStatus,
      ));
    } catch (e) {
      emit(FavouritesError('Failed to load favourites: $e'));
    }
  }

  Future<void> _onAddToFavourites(
    AddToFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      await _repository.addToFavourites(event.product);

      if (state is FavouritesLoaded) {
        final currentState = state as FavouritesLoaded;
        final updatedFavourites =
            List<ProductsModel>.from(currentState.favourites);

        if (!updatedFavourites.any((p) => p.id == event.product.id)) {
          updatedFavourites.add(event.product);
        }

        final updatedStatus = Map<int, bool>.from(currentState.favouriteStatus);
        updatedStatus[event.product.id!] = true;

        emit(currentState.copyWith(
          favourites: updatedFavourites,
          favouriteStatus: updatedStatus,
        ));
      }

      emit(FavouriteStatusUpdated(event.product.id!, true));
    } catch (e) {
      emit(FavouritesError('Failed to add to favourites: $e'));
    }
  }

  Future<void> _onRemoveFromFavourites(
    RemoveFromFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      await _repository.removeFromFavourites(event.productId);

      if (state is FavouritesLoaded) {
        final currentState = state as FavouritesLoaded;
        final updatedFavourites = currentState.favourites
            .where((product) => product.id != event.productId)
            .toList();

        final updatedStatus = Map<int, bool>.from(currentState.favouriteStatus);
        updatedStatus[event.productId] = false;

        emit(currentState.copyWith(
          favourites: updatedFavourites,
          favouriteStatus: updatedStatus,
        ));
      }

      emit(FavouriteStatusUpdated(event.productId, false));
    } catch (e) {
      emit(FavouritesError('Failed to remove from favourites: $e'));
    }
  }

  Future<void> _onCheckIsFavourite(
    CheckIsFavouriteEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    try {
      final isFavourite = await _repository.isFavourite(event.productId);

      if (state is FavouritesLoaded) {
        final currentState = state as FavouritesLoaded;
        final updatedStatus = Map<int, bool>.from(currentState.favouriteStatus);
        updatedStatus[event.productId] = isFavourite;

        emit(currentState.copyWith(favouriteStatus: updatedStatus));
      }

      emit(FavouriteStatusUpdated(event.productId, isFavourite));
    } catch (e) {
      emit(FavouritesError('Failed to check favourite status: $e'));
    }
  }
}
