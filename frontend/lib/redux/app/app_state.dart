import '../products/products_state.dart';

class AppState {
  ProductsState? productsState;

  AppState({this.productsState});

  factory AppState.initial() {
    return AppState(
      productsState: ProductsState.initial(),
    );
  }
}
