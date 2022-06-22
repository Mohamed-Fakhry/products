import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:products_crud/features/widget/product_table.dart';

import '../router/hero_dialog_route.dart';
import 'add_product_dialog.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    navigateToAddProductDialog() async {
      Navigator.push(
        context,
        HeroDialogRoute(
          builder: (BuildContext context) => AddProductDialog(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddProductDialog,
        label: Text("Add New Product"),
        heroTag: "addProductFAB",
      ),
      body: const ProductTable(),
    );
  }
}
