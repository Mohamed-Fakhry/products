import 'package:products_crud/redux/products/products_actions.dart';
import 'package:redux/redux.dart';

import '../../data/remote/products_repository.dart';
import '../action_report.dart';
import '../app/app_state.dart';

List<Middleware<AppState>> createProductsMiddleware([
  ProductsRepository _repository = const ProductsRepository(),
]) {
  final getProducts = _getProducts(_repository);
  final addProduct = _addProduct(_repository);
  final updateProduct = _updateProduct(_repository);
  final deleteProduct = _deleteProduct(_repository);

  return [
    TypedMiddleware<AppState, GetProductsAction>(getProducts),
    TypedMiddleware<AppState, AddProductAction>(addProduct),
    TypedMiddleware<AppState, UpdateProductAction>(updateProduct),
    TypedMiddleware<AppState, DeleteProductAction>(deleteProduct),
  ];
}

Middleware<AppState> _getProducts(ProductsRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);

    repository.getProducts().then((products) {
      next(SyncProductsAction(products));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, message);
    });
  };
}

Middleware<AppState> _addProduct(ProductsRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);

    repository.addProduct(action.product).then((product) {
      next(SyncProductAction(product));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, message);
    });
  };
}

Middleware<AppState> _updateProduct(ProductsRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);

    repository.updateProduct(action.product).then((product) {
      next(SyncProductAction(product));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, message);
    });
  };
}

Middleware<AppState> _deleteProduct(ProductsRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);

    repository.deleteProduct(action.product).then((student) {
      next(action);
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, message);
    });
  };
}

void catchError(NextDispatcher next, action, error) {
  next(
    ProductsStatusAction(
      ActionReport(
        actionName: action.actionName,
        status: ActionStatus.error,
        msg: error.toString(),
      ),
    ),
  );
}

void completed(NextDispatcher next, action) {
  next(
    ProductsStatusAction(
      ActionReport(
        actionName: action.actionName,
        status: ActionStatus.complete,
        msg: "${action.actionName} is completed",
      ),
    ),
  );
}

void running(NextDispatcher next, action) {
  next(
    ProductsStatusAction(
      ActionReport(
        actionName: action.actionName,
        status: ActionStatus.running,
        msg: "${action.actionName} is running",
      ),
    ),
  );
}

void idEmpty(NextDispatcher next, action) {
  next(
    ProductsStatusAction(
      ActionReport(
        actionName: action.actionName,
        status: ActionStatus.error,
        msg: "Id is empty",
      ),
    ),
  );
}
