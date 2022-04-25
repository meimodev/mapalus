import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapalus/shared/utils.dart';

class OrderInfo {
  int productCount;
  double productPrice;
  double deliveryWeight;
  double deliveryPrice;
  double deliveryDistance;
  LatLng deliveryCoordinate;
  String deliveryTime;

  OrderInfo({
    required this.deliveryDistance,
    required this.productCount,
    required this.productPrice,
    required this.deliveryWeight,
    required this.deliveryPrice,
    required this.deliveryCoordinate,
    this.deliveryTime = '',
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
        ),
        deliveryTime = data['delivery_time'];

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

  String get deliveryCoordinateF {
    return '${deliveryCoordinate.latitude}, ${deliveryCoordinate.longitude}';
  }

  String deliveryTimeF({bool shorted = false}) {
    var res = deliveryTime;
    if (res.contains("BESOK") && shorted) {
      res.substring(0, deliveryTime.length - 11);
    }
    return res;
  }

  OrderInfo copyWith({
    int? productCount,
    double? productPrice,
    double? deliveryWeight,
    double? deliveryPrice,
    double? deliveryDistance,
    LatLng? deliveryCoordinate,
    String? deliveryTime,
  }) {
    return OrderInfo(
      productCount: productCount ?? this.productCount,
      productPrice: productPrice ?? this.productPrice,
      deliveryWeight: deliveryWeight ?? this.deliveryWeight,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      deliveryDistance: deliveryDistance ?? this.deliveryDistance,
      deliveryCoordinate: deliveryCoordinate ?? this.deliveryCoordinate,
      deliveryTime: deliveryTime ?? this.deliveryTime,
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
          deliveryCoordinate == other.deliveryCoordinate &&
          deliveryTime == other.deliveryTime;

  @override
  int get hashCode =>
      productCount.hashCode ^
      productPrice.hashCode ^
      deliveryWeight.hashCode ^
      deliveryPrice.hashCode ^
      deliveryCoordinate.hashCode ^
      deliveryTime.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'product_count': productCount,
      'product_price': productPrice,
      'delivery_weight': deliveryWeight,
      'delivery_price': deliveryPrice,
      'delivery_distance': deliveryDistance,
      'delivery_time': deliveryTime,
      'delivery_coordinate': {
        'latitude': deliveryCoordinate.latitude,
        'longitude': deliveryCoordinate.longitude,
      },
    };
  }
}