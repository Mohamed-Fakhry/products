import 'package:products_crud/data/models/product_model.dart';
import 'package:products_crud/redux/products/products_state.dart';
import 'package:redux/redux.dart';

import 'products_actions.dart';

final productsReducer = combineReducers<ProductsState>([
  TypedReducer<ProductsState, ProductsStatusAction>(_syncAuthState),
  TypedReducer<ProductsState, SyncProductsAction>(_syncProducts),
  TypedReducer<ProductsState, SyncProductAction>(_syncProduct),
  TypedReducer<ProductsState, DeleteProductAction>(_deleteProduct),
]);

ProductsState _syncAuthState(ProductsState state, ProductsStatusAction action) {
  state.status!.update(
    action.report.actionName!,
    (v) => action.report,
    ifAbsent: () => action.report,
  );

  return state.copyWith(status: state.status);
}

ProductsState _syncProducts(ProductsState state, SyncProductsAction action) {
  state.products?.clear();

  for (Product product in action.products) {
    state.products!.update(
      product.id.toString(),
      (value) => product,
      ifAbsent: () => product,
    );
  }

  return state.copyWith(products: state.products, page: action.page);
}

ProductsState _syncProduct(ProductsState state, SyncProductAction action) {
  state.products!.update(
    action.product.id!,
    (value) => action.product,
    ifAbsent: () => action.product,
  );

  return state.copyWith(
    products: state.products,
  );
}

ProductsState _deleteProduct(ProductsState state, DeleteProductAction action) {
  state.products!.remove(action.product.id);
  return state.copyWith(products: state.products);
}
