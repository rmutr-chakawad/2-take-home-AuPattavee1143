import 'package:flutter/material.dart';
import 'package:products_firestore_app/models/products_model.dart';
import 'package:products_firestore_app/service/database.dart';
import 'package:products_firestore_app/widgets/product_Item.dart';
import 'package:products_firestore_app/widgets/product_form.dart';


class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Database.myInstance;
    Stream<List<ProductsModel>> myStream = db.getAllProductStream();

    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: myStream, 
        builder: (context, snapshot){
          if(snapshot.data!.isEmpty){
            return const Center(child: Text('ยังไม่มีข้อมูลสินค้า'),);
          }else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return Dismissible(
                  key: UniqueKey(), 
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white, size: 30,),
                  ),
                  confirmDismiss: (direction) async{
                    return await showDialog(
                      context: context, 
                      builder: (context) => showDeleteDialog(context, snapshot.data![index], db)
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context, 
                        builder: (context) {
                          return ProductForm(product: snapshot.data![index]);
                        },
                      );
                    },
                    child: Column(
                      children: [
                        ProductItem(product: snapshot.data![index],),
                        const Divider(thickness: 1, height: 1),
                      ],
                    )
                  )  
                );
              }
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }

  Widget showDeleteDialog(BuildContext context, ProductsModel product, Database db){
  return AlertDialog(
    title: const Text("ลบสินค้า"),
    content: const Text("คุณต้องการลบสินค้านี้ใช่หรือไม่?"),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("ยกเลิก"),
      ),
      TextButton(
        onPressed: () {
          db.deleteProduct(product: product);
          Navigator.of(context).pop();
        },
        child: const Text("ยืนยัน"),
      ),
    ],
  );
  }
}