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

  String id;
  String name;
  String description;
  String imageUrl;
  int price;
  String unit;
  String _status;
  String _weight;
  bool isCustomPrice;
  String category;
  int minimumPrice;

  Product.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        name = data["name"],
        description = data["description"],
        imageUrl = data["image"],
        price = data["price"],
        unit = data["unit"],
        _status = data["status"],
        _weight = data["weight"],
        isCustomPrice = data["custom_price"],
        category = data["category"],
        minimumPrice = data['minimum_price'] ?? 0;

  Product.empty()
      : id = "",
        name = "",
        description = "",
        imageUrl = "",
        price = 0,
        unit = "",
        _status = ProductStatus.unavailable.name,
        _weight = "0",
        isCustomPrice = false,
        category = "",
        minimumPrice = 0;

  ProductStatus get status => _status == ProductStatus.available.name
      ? ProductStatus.available
      : ProductStatus.unavailable;

  bool get isAvailable => status == ProductStatus.available;

  set isAvailable(bool isAvailable) => _status = isAvailable
      ? ProductStatus.available.name
      : ProductStatus.unavailable.name;

  String get priceF => Utils.formatNumberToCurrency(price);

  double get weight => double.parse(_weight);

  String get weightF =>
      '${Utils.formatNumberToCurrency(weight).replaceFirst('Rp. ', '')} gram';

  // bool get isQuantityNotEditable =>
  //     name.contains("l )") || name.contains("g )");

  set weight(double weight) => _weight = weight.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product{id: $id, name: $name, '
        'description: $description, imageUrl: $imageUrl, '
        'price: $price, unit: $unit, '
        'status: $status, isCustomPrice: $isCustomPrice, '
        'category:$category minimumPrice $minimumPrice}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': imageUrl,
      'price': price,
      'unit': unit,
      'status': _status,
      'weight': _weight,
      'custom_price': isCustomPrice,
      'category': category,
      'minimum_price': minimumPrice,
    };
  }
}
