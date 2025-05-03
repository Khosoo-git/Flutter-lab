import 'package:flutter/material.dart';
import 'package:lab6/product_card.dart';
import '../controllers/product_controller.dart';
import '../data/product_data.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController(
      ProductData.of(context).productService,
    );
    final products = controller.getAllProducts();

    return Scaffold(
      appBar: AppBar(title: const Text('E Commerce')),
      body: ListView(
        children: products.map((p) => ProductCard(product: p)).toList(),
      ),
    );
  }
}
