import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/shared/utils.dart';

class ProductOrder {
  Product product;
  double quantity;
  double totalPrice;

  ProductOrder({
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  String toString() {
    return 'ProductOrder{product: ${product.toString()}, quantity: $quantity, totalPrice: $totalPrice}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductOrder && product.id == other.product.id;

  @override
  int get hashCode =>
      product.hashCode ^ quantity.hashCode ^ totalPrice.hashCode;

  String get quantityString {
    String s = quantity.toStringAsFixed(2);
    return s.replaceFirst(".00", "");
  }

  String get totalPriceString {
    String s = totalPrice.toStringAsFixed(2).replaceFirst(".00", "");
    return Utils.formatNumberToCurrency(int.parse(s));
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
      'total_price': totalPrice,
    };
  }

  ProductOrder.fromMap(Map<String, dynamic> data)
      : quantity = double.parse(data["quantity"].toString()),
        totalPrice = double.parse(data["total_price"].toString()),
        product = Product.fromMap(data['product']);
}