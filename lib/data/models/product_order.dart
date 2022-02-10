import 'package:mapalus/data/models/product.dart';

class ProductOrder {
  late Product product;
  late int quantity;
  late int totalPrice;

  ProductOrder({
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });
}