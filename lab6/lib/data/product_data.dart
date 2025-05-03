import 'package:flutter/material.dart';
import '../services/product_service.dart';

class ProductData extends InheritedWidget {
  final ProductService productService = ProductService();

  ProductData({super.key, required super.child});

  static ProductData of(BuildContext context) {
    final ProductData? result =
        context.dependOnInheritedWidgetOfExactType<ProductData>();
    assert(result != null, 'No ProductData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ProductData oldWidget) => false;
}
