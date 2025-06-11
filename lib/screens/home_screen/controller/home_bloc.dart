import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refulgence/screens/home_screen/model/products_model.dart';
import 'package:refulgence/screens/home_screen/service/home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final products = await HomeService.getProducts();
      if (products != null) {
        emit(HomeLoaded(products: products));
      } else {
        emit(HomeError(message: 'Failed to load products'));
      }
    } catch (e) {
      emit(HomeError(message: 'Error: ${e.toString()}'));
    }
  }

  void _onSearchProducts(SearchProductsEvent event, Emitter<HomeState> emit) {
    final currentState = state;

    List<ProductsModel> allProducts = [];

    if (currentState is HomeLoaded) {
      allProducts = currentState.products ?? [];
    } else if (currentState is HomeSearchResults) {
      allProducts = currentState.allProducts;
    } else {
      return;
    }

    if (event.query.isEmpty) {
      emit(HomeLoaded(products: allProducts));
      return;
    }

    final filteredProducts = allProducts.where((product) {
      final title = product.title?.toLowerCase() ?? '';
      final body = product.body?.toLowerCase() ?? '';
      final query = event.query.toLowerCase();

      return title.contains(query) || body.contains(query);
    }).toList();

    emit(HomeSearchResults(
      filteredProducts: filteredProducts,
      allProducts: allProducts,
      searchQuery: event.query,
    ));
  }
}
