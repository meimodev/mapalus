import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

abstract class ProductRepoContract {
  Future<Product> readProduct(int id);

  Future<List<Product>> readProducts();

  Future<Product> searchProduct();
}

class ProductRepo extends ProductRepoContract {
  FirestoreService firestore = FirestoreService();

  @override
  Future<Product> readProduct(int id) {
    // TODO: implement readProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> readProducts() async {
    return Future.value([]);
  }

  @override
  Future<Product> searchProduct() {
    // TODO: implement searchProduct
    throw UnimplementedError();
  }

  Future<List<Product>> getProducts() async {
    final res = await firestore.getProducts();
    final data = res.map((e) => Product.fromMap(e as Map<String, dynamic>)).toList();
    return data;
  }
}