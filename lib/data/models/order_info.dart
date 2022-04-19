import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapalus/shared/utils.dart';

class OrderInfo {
  int productCount;
  double productPrice;
  double deliveryWeight;
  double deliveryPrice;
  double deliveryDistance;
  LatLng deliveryCoordinate;

  OrderInfo({
    required this.deliveryDistance,
    required this.productCount,
    required this.productPrice,
    required this.deliveryWeight,
    required this.deliveryPrice,
    required this.deliveryCoordinate,
  });

  OrderInfo.fromMap(Map<String, dynamic> data)
      : productCount = data["product_count"],
        productPrice = data["product_price"],
        deliveryWeight = data["delivery_weight"],
        deliveryPrice = data["delivery_price"],
        deliveryDistance = data["delivery_distance"],
        deliveryCoordinate = LatLng(
          data["delivery_coordinate"]["latitude"],
          data["delivery_coordinate"]["longitude"],
        );

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
    LatLng? deliveryCoordinate,
  }) {
    return OrderInfo(
      productCount: productCount ?? this.productCount,
      productPrice: productPrice ?? this.productPrice,
      deliveryWeight: deliveryWeight ?? this.deliveryWeight,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      deliveryDistance: deliveryDistance ?? this.deliveryDistance,
      deliveryCoordinate: deliveryCoordinate ?? this.deliveryCoordinate,
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
          deliveryPrice == other.deliveryPrice &&
          deliveryCoordinate == other.deliveryCoordinate;

  @override
  int get hashCode =>
      productCount.hashCode ^
      productPrice.hashCode ^
      deliveryWeight.hashCode ^
      deliveryPrice.hashCode ^
      deliveryCoordinate.hashCode;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> _deliveryCoordinate = {
      'latitude': deliveryCoordinate.latitude,
      'longitude': deliveryCoordinate.longitude,
    };
    return {
      'product_count': productCount,
      'product_price': productPrice,
      'delivery_weight': deliveryWeight,
      'delivery_price': deliveryPrice,
      'delivery_distance': deliveryDistance,
      'delivery_coordinate': _deliveryCoordinate,
    };
  }
}