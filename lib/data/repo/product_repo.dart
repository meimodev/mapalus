import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/services/firebase_services.dart';

abstract class ProductRepoContract {
  Future<Product> readProduct(int id);

  Future<List<Product>> readProducts();

  Future<Product> searchProduct();
}

class ProductRepo extends ProductRepoContract {
  FirestoreService firebaseServices = FirestoreService();

  @override
  Future<Product> readProduct(int id) {
    // TODO: implement readProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> readProducts() async {
    await firebaseServices.getProducts();
    return Future.value([]);
  }

  @override
  Future<Product> searchProduct() {
    // TODO: implement searchProduct
    throw UnimplementedError();
  }
}