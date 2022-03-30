import 'package:mapalus/shared/utils.dart';

class OrderInfo {
  int productCount;
  double productPrice;
  double deliveryWeight;
  double deliveryPrice;
  double deliveryDistance;

  OrderInfo({
    required this.deliveryDistance,
    required this.productCount,
    required this.productPrice,
    required this.deliveryWeight,
    required this.deliveryPrice,
  });

  String get totalPrice {
    double t = deliveryPrice + productPrice;
    return Utils.formatNumberToCurrency(t);
  }

  String get productPriceF {
    return Utils.formatNumberToCurrency(productPrice);
  }

  String get productCountF {
    return '$productCount Produk';
  }

  String get deliveryPriceF {
    return Utils.formatNumberToCurrency(deliveryPrice);
  }

  String get deliveryWeightF {
    return '$deliveryWeight Kg $deliveryDistance Km';
  }

  OrderInfo copyWith({
    int? productCount,
    double? productPrice,
    double? deliveryWeight,
    double? deliveryPrice,
    double? deliveryDistance,
  }) {
    return OrderInfo(
      productCount: productCount ?? this.productCount,
      productPrice: productPrice ?? this.productPrice,
      deliveryWeight: deliveryWeight ?? this.deliveryWeight,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      deliveryDistance: deliveryDistance ?? this.deliveryDistance,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderInfo &&
          runtimeType == other.runtimeType &&
          productCount == other.productCount &&
          productPrice == other.productPrice &&
          deliveryWeight == other.deliveryWeight &&
          deliveryPrice == other.deliveryPrice;

  @override
  int get hashCode =>
      productCount.hashCode ^
      productPrice.hashCode ^
      deliveryWeight.hashCode ^
      deliveryPrice.hashCode;
}