import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:products_crud/features/widget/product_item.dart';

import '../../redux/app/app_state.dart';
import '../products_view_model.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductsViewModel>(
      distinct: true,
      converter: (store) => ProductsViewModel.fromStore(store),
      builder: (_, viewModel) => ProductTableConntent(
        viewModel: viewModel,
      ),
    );
  }
}

class ProductTableConntent extends StatefulWidget {
  final ProductsViewModel viewModel;

  ProductTableConntent({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<ProductTableConntent> createState() => _ProductTableConntentState();
}

class _ProductTableConntentState extends State<ProductTableConntent> {
  @override
  void initState() {
    widget.viewModel.getProduts!.call();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductTableConntent oldWidget) {
    print(widget.viewModel.products?.length);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 32,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(0xfffbd589),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                expandedTitles("Product Name", 2),
                expandedTitles("Descripation", 3),
                expandedTitles("Brand", 2),
                expandedTitles("Price", 2),
                expandedTitles("Actions", 2),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.viewModel.products!.length,
            itemBuilder: ((context, index) {
              return ProductItem(
                isEven: index.isEven,
                product: widget.viewModel.products![index],
              );
            }),
          ),
        )
      ],
    );
  }

  expandedTitles(String title, int flex) {
    return Expanded(
      flex: flex,
      child: Align(
        alignment: title == "Student" ? Alignment.centerLeft : Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: const TextStyle(
                color: Color(0xa21a1c19),
                fontWeight: FontWeight.w700,
                fontSize: 11.0),
          ),
        ),
      ),
    );
  }
}
