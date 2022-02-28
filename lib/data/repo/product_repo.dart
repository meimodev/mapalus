import 'package:mapalus/data/models/product.dart';

abstract class ProductRepoContract {
  Future<Product> readProduct(int id);
  Future<List<Product>> readProducts();
  Future<Product> searchProduct();
}