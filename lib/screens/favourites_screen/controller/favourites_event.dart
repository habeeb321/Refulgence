import 'package:refulgence/screens/home_screen/model/products_model.dart';

abstract class FavouritesEvent {}

class LoadFavouritesEvent extends FavouritesEvent {}

class AddToFavouritesEvent extends FavouritesEvent {
  final ProductsModel product;
  AddToFavouritesEvent(this.product);
}

class RemoveFromFavouritesEvent extends FavouritesEvent {
  final int productId;
  RemoveFromFavouritesEvent(this.productId);
}

class CheckIsFavouriteEvent extends FavouritesEvent {
  final int productId;
  CheckIsFavouriteEvent(this.productId);
}