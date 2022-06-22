import 'package:products_crud/data/models/product_model.dart';

import '../models/page_model.dart';
import '../models/pair_model.dart';
import 'network_common.dart';

class ProductsRepository {
  const ProductsRepository();

  Future<List<Product>> getProducts() {
    return NetworkCommon()
        .dio
        .get(
          "products",
        )
        .then((response) {
      List<Product> products = (response.data as List)
          .map((product) => Product.fromJson(product))
          .toList();

      return products;
    });
  }

  Future<Product> addProduct(Product product) async {
    return NetworkCommon()
        .dio
        .post("products", data: product.toJson())
        .then((response) {
      return Product.fromJson(response.data);
    });
  }

  Future<Product> updateProduct(Product product) async {
    return NetworkCommon()
        .dio
        .put("products/${product.id}", data: product.toJson())
        .then((response) {
      return Product.fromJson(response.data);
    });
  }

  Future<Product> deleteProduct(Product product) async {
    return NetworkCommon()
        .dio
        .delete("products/${product.id}")
        .then((response) {
      return Product.fromJson(response.data);
    });
  }
}
