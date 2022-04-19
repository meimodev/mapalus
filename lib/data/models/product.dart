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
  final String _unit;
  final String _status;
  final String _weight;
  final bool isCustomPrice;

  Product.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        name = data["name"],
        description = data["description"],
        imageUrl = data["image"],
        price = data["price"],
        _unit = data["unit"],
        _status = data["status"],
        _weight = data["weight"],
        isCustomPrice = data["custom_price"];

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

  String get priceF => Utils.formatNumberToCurrency(price);

  double get weight => double.parse(_weight);

  String get unit => _unit.toLowerCase().contains("kilogram") ? "Kg" : _unit;

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price, unit: $unit, status: $status, isCustomPrice: $isCustomPrice}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': imageUrl,
      'price': price,
      'unit': _unit,
      'status': _status,
      'weight': _weight,
      'custom_price': isCustomPrice,
    };
  }
}