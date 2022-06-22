import 'package:flutter/foundation.dart';

import '../../data/models/page_model.dart';
import '../../data/models/product_model.dart';
import '../action_report.dart';

class ProductsStatusAction {
  final String actionName = "ProductsStatusAction";
  final ActionReport report;

  ProductsStatusAction(this.report);
}

class GetProductsAction {
  final String actionName = "GetProductsAction";
  final int? page;

  GetProductsAction({this.page});
}

class SyncProductsAction {
  final String actionName = "SyncProductsAction";
  final List<Product> products;
  final Page? page;

  SyncProductsAction(this.products, {this.page});
}

class SyncProductAction {
  final String actionName = "SyncProductAction";
  final Product product;

  SyncProductAction(this.product);
}

class AddProductAction {
  final String actionName = "AddProductAction";
  final Product product;

  AddProductAction(this.product);
}

class UpdateProductAction {
  final String actionName = "UpdateProductAction";
  final Product? product;

  UpdateProductAction(this.product);
}

class DeleteProductAction {
  final String actionName = "DeleteProductAction";
  final Product product;

  DeleteProductAction(this.product);
}
