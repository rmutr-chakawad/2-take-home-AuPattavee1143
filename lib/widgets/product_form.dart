import 'package:flutter/material.dart';
import 'package:products_firestore_app/models/products_model.dart';
import 'package:products_firestore_app/service/database.dart';

class ProductForm extends StatefulWidget {

  ProductsModel? product;
  ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  Database db = Database.myInstance;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.product != null){
      nameController.text = widget.product!.productname;
      priceController.text = widget.product!.price.toString();
    }
  }

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.product == null ? 'เพิ่มสินค้า' : 'เเก้ไข ${widget.product!.productname}'),
        TextField(
          controller: nameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: 'ชื่อสินค้า'),
        ),
        TextField(
          controller: priceController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: 'ราคาสินค้า'),
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showbntOK(context),
            const SizedBox(width: 10,),
            showbtncancel(context,)
          ],
        ),
      ],
    );
  }

  Widget showbntOK(BuildContext context){
    return ElevatedButton(
      onPressed: () async{
        String newId = 'PD${DateTime.now().microsecondsSinceEpoch.toString()}';
        await db.setProduct(
          product: ProductsModel(
            id: widget.product == null ? newId : widget.product!.id, 
            productname: nameController.text, 
            price: double.tryParse(priceController.text) ?? 0
          )
        );
        nameController.clear();
        priceController.clear();
        Navigator.of(context).pop();
      }, 
      child: const Text('เพิ่ม'));
  }

  Widget showbtncancel(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        
        Navigator.of(context).pop();
      }, 
      child: const Text('เพิ่ม'));
  }
}