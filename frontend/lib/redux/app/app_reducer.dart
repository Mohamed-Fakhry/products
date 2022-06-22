import '../products/products_reducer.dart';
import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    productsState: productsReducer(state.productsState!, action),
  );
}
