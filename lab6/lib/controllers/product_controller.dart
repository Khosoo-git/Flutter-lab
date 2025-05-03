import '../models/product.dart';
import '../services/product_service.dart';

class ProductController {
  final ProductService productService;

  ProductController(this.productService);

  List<Product> getAllProducts() {
    return productService.getProducts();
  }
}
