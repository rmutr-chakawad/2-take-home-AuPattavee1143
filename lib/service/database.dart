import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_firestore_app/models/products_model.dart';

class Database {
  static Database myInstance = Database();

  Stream<List<ProductsModel>> getAllProductStream(){
    var reference = FirebaseFirestore.instance.collection('products');
    
    Query query = reference.orderBy('id', descending: true);
    var querysnapshot = query.snapshots();

    return querysnapshot.map((snapshot){
      return snapshot.docs.map((doc){
        return ProductsModel.formMap(doc.data() as Map<String, dynamic>);}).toList();
    });
  }

  Future<void> setProduct({required ProductsModel product}) async{
    var reference = FirebaseFirestore.instance.doc('products/${product.id}');
    try {
      await reference.set(product.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct({required ProductsModel product}) async{
    var reference = FirebaseFirestore.instance.doc('products/${product.id}');
    try {
      await reference.delete();
    } catch (e) {
      rethrow;
    }
  }
}