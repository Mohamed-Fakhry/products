import 'package:products_crud/data/models/product_model.dart';

import '../../data/models/page_model.dart';
import '../action_report.dart';

class ProductsState {
  final Map<String, ActionReport>? status;
  final Map<String, Product>? products;
  Page? page;

  ProductsState({
    this.status,
    this.products,
    this.page,
  });

  factory ProductsState.initial() {
    return ProductsState(
      status: {},
      page: Page(),
    );
  }

  ProductsState copyWith({
    Map<String, ActionReport>? status,
    final Map<String, Product>? products,
    Page? page,
  }) {
    return ProductsState(
      status: status ?? this.status ?? {},
      products: products ?? this.products ?? {},
      page: page ?? this.page,
    );
  }
}
