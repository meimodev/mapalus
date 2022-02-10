import 'package:mapalus/shared/enums.dart';

class Product {
  late int id;
  late String name;
  late String description;
  late String imageUrl;
  late String price;
  late String unit;
  late ProductStatus status;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.unit,
    required this.status,
  });
}