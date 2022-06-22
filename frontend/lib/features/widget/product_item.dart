import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:products_crud/features/delete_product_dialog.dart';
import 'package:products_crud/features/update_produt_dialog.dart';

import '../../data/models/product_model.dart';
import '../../redux/app/app_state.dart';
import '../../router/hero_dialog_route.dart';
import '../products_view_model.dart';

class ProductItem extends StatelessWidget {
  bool isEven;
  Product product;

  ProductItem({
    Key? key,
    required this.product,
    this.isEven = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductsViewModel>(
      distinct: true,
      converter: (store) => ProductsViewModel.fromStore(store),
      builder: (_, viewModel) => ProductItemContent(
        viewModel: viewModel,
        isEven: isEven,
        product: product,
      ),
    );
  }
}

class ProductItemContent extends StatefulWidget {
  final ProductsViewModel viewModel;
  bool isEven;
  Product product;

  ProductItemContent({
    Key? key,
    required this.viewModel,
    required this.product,
    this.isEven = false,
  }) : super(key: key);

  @override
  State<ProductItemContent> createState() => _ProductItemContentState();
}

class _ProductItemContentState extends State<ProductItemContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: widget.isEven ? const Color(0xffdcf3f7) : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              expandedValues(
                Text(
                  widget.product.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 12.5),
                  textAlign: TextAlign.center,
                ),
                2,
              ),
              expandedValues(
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.product.description!,
                    style: const TextStyle(color: Colors.black, fontSize: 11.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                3,
              ),
              expandedValues(
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.product.brand!,
                    style: const TextStyle(color: Colors.black, fontSize: 11.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                2,
              ),
              expandedValues(
                Text(
                  widget.product.price.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 11.0),
                  textAlign: TextAlign.center,
                ),
                2,
              ),
              expandedValues(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          HeroDialogRoute(
                            builder: (BuildContext context) =>
                                UpdateProductDialog(
                                    product: widget.product.copy()),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          HeroDialogRoute(
                            builder: (BuildContext context) =>
                                DeleteProductDialog(product: widget.product),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.delete,
                        size: 14,
                      ),
                    )
                  ],
                ),
                2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  expandedValues(Widget widget, int flex) {
    return Expanded(
      flex: flex,
      child: widget,
    );
  }
}
