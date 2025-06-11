import 'package:refulgence/screens/home_screen/model/products_model.dart';

abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<ProductsModel> favourites;
  final Map<int, bool> favouriteStatus;

  FavouritesLoaded({
    required this.favourites,
    required this.favouriteStatus,
  });

  FavouritesLoaded copyWith({
    List<ProductsModel>? favourites,
    Map<int, bool>? favouriteStatus,
  }) {
    return FavouritesLoaded(
      favourites: favourites ?? this.favourites,
      favouriteStatus: favouriteStatus ?? this.favouriteStatus,
    );
  }
}

class FavouritesError extends FavouritesState {
  final String message;
  FavouritesError(this.message);
}

class FavouriteStatusUpdated extends FavouritesState {
  final int productId;
  final bool isFavourite;
  FavouriteStatusUpdated(this.productId, this.isFavourite);
}
