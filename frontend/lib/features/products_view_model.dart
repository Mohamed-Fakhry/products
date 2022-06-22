import 'package:products_crud/data/models/product_model.dart';
import 'package:products_crud/redux/products/products_actions.dart';
import 'package:redux/redux.dart';

import '../redux/action_report.dart';
import '../redux/app/app_state.dart';

class ProductsViewModel {
  final Product? product;
  final List<Product>? products;
  final Function()? getProduts;
  final ActionReport? getProductsReport;
  final Function(Product)? createProduct;
  final Function(Product)? deleteProduct;
  final Function(Product)? updateProduct;
  final ActionReport? createProductReport;
  final ActionReport? deleteProductReport;
  final ActionReport? updateProductReport;

  ProductsViewModel({
    this.product,
    this.products,
    this.getProduts,
    this.getProductsReport,
    this.createProduct,
    this.deleteProduct,
    this.updateProduct,
    this.createProductReport,
    this.deleteProductReport,
    this.updateProductReport,
  });

  static ProductsViewModel fromStore(Store<AppState> store) {
    return ProductsViewModel(
      products: store.state.productsState!.products?.values.toList() ?? [],
      getProduts: () {
        store.dispatch(GetProductsAction());
      },
      createProduct: (product) {
        store.dispatch(AddProductAction(product));
      },
      deleteProduct: (product) {
        store.dispatch(DeleteProductAction(product));
      },
      updateProduct: (product) {
        store.dispatch(UpdateProductAction(product));
      },
      getProductsReport:
          store.state.productsState!.status?["GetProductsAction"],
      createProductReport:
          store.state.productsState!.status?["AddProductAction"],
      deleteProductReport:
          store.state.productsState!.status?["DeleteProductAction"],
      updateProductReport:
          store.state.productsState!.status?["UpdateProductAction"],
    );
  }
}
