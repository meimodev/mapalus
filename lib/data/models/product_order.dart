import 'package:mapalus/data/models/product.dart';

class ProductOrder {
  late Product product;
  late double quantity;
  late int totalPrice;

  ProductOrder({
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  String toString() {
    return 'ProductOrder{product: ${product.toString()}, quantity: $quantity, totalPrice: $totalPrice}';
  }
}