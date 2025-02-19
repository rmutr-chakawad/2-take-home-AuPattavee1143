import 'package:flutter/material.dart';
import 'package:products_firestore_app/models/products_model.dart';
import 'package:products_firestore_app/service/database.dart';

class ProductForm extends StatefulWidget {

  final ProductsModel? product;
  const ProductForm({super.key, this.product});

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
    bool isEditing = widget.product != null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(isEditing ? 'เเก้ไขสินค้า "${widget.product!.productname}"' : 'เพิ่มสินค้า'),
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
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showbtncancel(context),
            const SizedBox(width: 50,),
            showbntOK(context, isEditing),
          ],
        ),
      ],
    );
  }

  Widget showbntOK(BuildContext context, bool isEditing){
    return ElevatedButton(
      onPressed: () async{
        String newId = isEditing ? widget.product!.id : 'PD${DateTime.now().microsecondsSinceEpoch.toString()}';
        ProductsModel product = ProductsModel(
          id: newId,
          productname: nameController.text, 
          price: double.tryParse(priceController.text) ?? 0
        );
        await db.setProduct(product: product);
        nameController.clear();
        priceController.clear();
        Navigator.of(context).pop();
      }, 
      child: Text(isEditing ? 'บันทึก' : 'เพิ่ม' )
      );
    }

  Widget showbtncancel(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        Navigator.of(context).pop();
      }, 
      child: const Text('ยกเลิก'));
  }

}