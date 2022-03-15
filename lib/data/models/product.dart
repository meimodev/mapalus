import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/utils.dart';

class Product {
  // int id;
  // String name;
  // String description;
  // String imageUrl;
  // int price;
  // String unit;
  // ProductStatus status;
  // bool isCustomPrice;

  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  final String unit;
  final String _status;
  final bool isCustomPrice;

  Product.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        imageUrl = json["imageUrl"],
        price = json["price"],
        unit = json["unit"],
        _status = json["status"],
        isCustomPrice = json["isCustomPrice"];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  ProductStatus get status => _status == "available"
      ? ProductStatus.available
      : ProductStatus.unavailable;

  bool get isAvailable => status == ProductStatus.available;

  String get priceFormatted => Utils.formatNumberToCurrency(price);

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price, unit: $unit, status: $status, isCustomPrice: $isCustomPrice}';
  }
}