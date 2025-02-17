import 'package:flutter/material.dart';
import 'package:products_firestore_app/models/products_model.dart';
import 'package:products_firestore_app/widgets/product_popup.dart';

class ProductItem extends StatelessWidget {
  ProductsModel product;
  ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context,
          builder: (context){
            return ProductPopup();
          });
      },
      child: ListTile(
        leading: Text(product.productname),
        title: Text(product.price.toStringAsFixed(2), textAlign: TextAlign.right,),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}