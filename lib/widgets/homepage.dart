import 'package:flutter/material.dart';
import 'package:products_firestore_app/widgets/product_list.dart';
import 'package:products_firestore_app/widgets/product_popup.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List'),actions: [
        IconButton(
          onPressed: (){
            showModalBottomSheet(
              isScrollControlled: true,
              context: context, 
              builder: (context)=> ProductPopup()
              );
          }, 
          icon: const Icon(Icons.add))
      ],),
      body: const ProductList(),
    );
  }
}