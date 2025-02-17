import 'package:flutter/material.dart';
import 'package:products_firestore_app/models/products_model.dart';
import 'package:products_firestore_app/widgets/product_form.dart';

class ProductPopup extends StatelessWidget {
  ProductsModel? product;
  ProductPopup({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.white
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        child: ProductForm(),
      ),
    );
  }
}