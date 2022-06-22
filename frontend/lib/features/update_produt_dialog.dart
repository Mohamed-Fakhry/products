import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:products_crud/data/models/product_model.dart';
import 'package:products_crud/features/products_view_model.dart';
import 'package:products_crud/utils/toast_utils.dart';

import '../redux/action_report.dart';
import '../redux/app/app_state.dart';

class UpdateProductDialog extends StatelessWidget {
  Product product;

  UpdateProductDialog({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProductsViewModel>(
      distinct: true,
      converter: (store) => ProductsViewModel.fromStore(store),
      builder: (_, viewModel) => ProductDialogViewContent(
        viewModel: viewModel,
        product: product,
      ),
    );
  }
}

class ProductDialogViewContent extends StatefulWidget {
  final ProductsViewModel viewModel;
  Product product;

  ProductDialogViewContent({
    Key? key,
    required this.viewModel,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDialogViewContentState createState() =>
      _ProductDialogViewContentState();
}

class _ProductDialogViewContentState extends State<ProductDialogViewContent> {
  final double padding = 16.0;
  final double avatarRadius = 50.0;
  late bool isloading, isCompleted;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  dialogContent(BuildContext context) {
    isloading =
        widget.viewModel.updateProductReport?.status == ActionStatus.running;
    isCompleted =
        widget.viewModel.updateProductReport?.status == ActionStatus.complete;

    if (isCompleted)
      Future.delayed(
        Duration(seconds: 1),
        () => widget.viewModel.updateProductReport?.status = null,
      );

    showContent() {
      if (isloading) {
        return <Widget>[
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Updating the Product...",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: avatarRadius),
        ];
      } else if (isCompleted) {
        return <Widget>[
          const Text(
            "Product Updated Successfully",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16.0),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () {},
                    child: const Text(
                      "",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ];
      } else {
        return <Widget>[
          const Text(
            "Update Product",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            maxLines: 1,
            textAlign: TextAlign.center,
            controller: TextEditingController(text: widget.product.name),
            onChanged: (name) => widget.product.name = name,
            decoration: InputDecoration(
              hintText: "Name of product",
              contentPadding: const EdgeInsets.all(20.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            textAlign: TextAlign.center,
            controller: TextEditingController(text: widget.product.description),
            onChanged: (description) =>
                widget.product.description = description,
            decoration: InputDecoration(
              hintText: "Descripation",
              contentPadding: const EdgeInsets.all(20.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            textAlign: TextAlign.center,
            controller:
                TextEditingController(text: widget.product.price.toString()),
            onChanged: (price) => widget.product.price = num.tryParse(price),
            decoration: InputDecoration(
              hintText: "Price",
              contentPadding: const EdgeInsets.all(20.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            textAlign: TextAlign.center,
            controller:
                TextEditingController(text: widget.product.price.toString()),
            onChanged: (brand) => widget.product.brand = brand,
            decoration: InputDecoration(
              hintText: "Brand",
              contentPadding: const EdgeInsets.all(20.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () {
                if (validateProduct()) {
                  widget.viewModel.updateProduct!.call(widget.product);
                }
              },
              child: Text(
                "Submit",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ];
      }
    }

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.only(
              top: avatarRadius + padding,
              bottom: padding,
              left: padding,
              right: padding,
            ),
            margin: EdgeInsets.only(top: avatarRadius),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: showContent(),
            ),
          ),
          Positioned(
            left: padding,
            right: padding,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              radius: avatarRadius,
              child: isloading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Icon(
                      isCompleted ? Icons.check : Icons.help_outline,
                      size: avatarRadius,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateProduct() {
    if (widget.product.name == null) {
      showToast("Please product name");
      return false;
    }

    if (widget.product.description == null) {
      showToast("Please product description");
      return false;
    }

    if (widget.product.price == null) {
      showToast("Please product price");
      return false;
    }

    if (widget.product.brand == null) {
      showToast("Please product brand");
      return false;
    }
    return true;
  }
}
