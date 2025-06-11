import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:refulgence/core/constants.dart';
import 'dart:convert';
import 'package:refulgence/screens/home_screen/model/products_model.dart';

class FavouritesRepository {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _favouritesKey = 'favourite_products';

  Future<List<ProductsModel>> getFavourites() async {
    try {
      final favouritesJson = await _storage.read(key: _favouritesKey);
      if (favouritesJson != null) {
        final favouritesList = json.decode(favouritesJson) as List;
        return favouritesList
            .map((json) => ProductsModel.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      Constants.logger.e('Error loading favourites: $e');
      return [];
    }
  }

  Future<void> saveFavourites(List<ProductsModel> favourites) async {
    try {
      final favouritesJson =
          json.encode(favourites.map((product) => product.toJson()).toList());
      await _storage.write(key: _favouritesKey, value: favouritesJson);
    } catch (e) {
      print('Error saving favourites: $e');
    }
  }

  Future<bool> isFavourite(int productId) async {
    final favourites = await getFavourites();
    return favourites.any((product) => product.id == productId);
  }

  Future<void> addToFavourites(ProductsModel product) async {
    final favourites = await getFavourites();
    if (!favourites.any((p) => p.id == product.id)) {
      favourites.add(product);
      await saveFavourites(favourites);
    }
  }

  Future<void> removeFromFavourites(int productId) async {
    final favourites = await getFavourites();
    favourites.removeWhere((product) => product.id == productId);
    await saveFavourites(favourites);
  }
}
