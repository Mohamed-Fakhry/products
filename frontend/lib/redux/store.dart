import 'package:products_crud/redux/products/products_middleware.dart';
import 'package:redux/redux.dart';

import 'app/app_reducer.dart';
import 'app/app_state.dart';

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      ...createProductsMiddleware(),
    ],
  );
}
