import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refulgence/screens/home_screen/model/products_model.dart';
import 'package:refulgence/screens/home_screen/service/home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
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
}
