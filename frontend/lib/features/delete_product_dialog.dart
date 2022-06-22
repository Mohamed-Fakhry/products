import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:products_crud/data/models/product_model.dart';
import 'package:products_crud/features/products_view_model.dart';
import 'package:products_crud/utils/toast_utils.dart';

import '../redux/action_report.dart';
import '../redux/app/app_state.dart';

class DeleteProductDialog extends StatelessWidget {
  Product product;
  DeleteProductDialog({required this.product});

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
        widget.viewModel.deleteProductReport?.status == ActionStatus.running;
    isCompleted =
        widget.viewModel.deleteProductReport?.status == ActionStatus.complete;

    if (isCompleted)
      Future.delayed(
        Duration(seconds: 2),
        () => widget.viewModel.deleteProductReport?.status = null,
      );

    showContent() {
      if (isloading) {
        return <Widget>[
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Deleting the Product...",
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
            "Product Deleted Successfully",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16.0),
        ];
      } else {
        return <Widget>[
          const Text(
            "Delete Product",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            "Are you sure you want to delete this product?",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    widget.viewModel.deleteProduct!.call(widget.product);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
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
}
