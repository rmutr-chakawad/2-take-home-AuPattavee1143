class ProductsModel {
  String id;
  String productname;
  double price;

  ProductsModel({required this.id, required this.productname, required this.price});

  factory ProductsModel.formMap(Map<String, dynamic> product){
    if(product.isEmpty){
      throw ArgumentError('ไม่พบ product');
    }else{
      var obj = ProductsModel(
        id: product['id'], 
        productname: product['productname'], 
        price: product['price']);
        return obj;
    }
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> data;
      data = {
        'id' : id,
        'productname' : productname,
        'price' : price
      };
      return data;
  }
}

