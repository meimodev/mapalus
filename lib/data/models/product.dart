import 'package:mapalus/shared/enums.dart';

class Product {
  int id;
  String name;
  String description;
  String imageUrl;
  int price;
  String unit;
  ProductStatus status;
  bool isCustomPrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.unit = 'gram',
    this.isCustomPrice = false,
    required this.status,
  });

  bool get isAvailable => status == ProductStatus.available;

  String get priceFormatted => "Rp. " + price.toString();

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price, unit: $unit, status: $status, isCustomPrice: $isCustomPrice}';
  }
}