import '../models/product.dart';

class ProductService {
  static final List<Product> _products = [
    Product(
      id: 1,
      name: 'Mouse',
      price: 100.0,
      description: 'This is a computer mouse',
      imageUrl: 'images/mouse.png',
    ),
    Product(
      id: 2,
      name: 'Shoes',
      price: 1000.0,
      description: 'These are shoes',
      imageUrl: 'images/shoes.jpg',
    ),
    Product(
      id: 3,
      name: 'BoAT headset 360',
      price: 1999.0,
      description: 'This is a branded headset',
      imageUrl: 'images/headset.webp',
    ),
    Product(
      id: 4,
      name: 'Glasses',
      price: 25.0,
      description: 'Glasses to protect your eyes',
      imageUrl: 'images/glasses.webp',
    ),
    Product(
      id: 5,
      name: 'Apple Products',
      price: 1000.0,
      description: 'Various apple products',
      imageUrl: 'images/apple.jpg',
    ),
  ];

  List<Product> getProducts() {
    return _products;
  }
}
