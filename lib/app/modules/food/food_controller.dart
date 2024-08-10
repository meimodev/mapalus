import 'package:get/get.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:uuid/uuid.dart';

class FoodController extends GetxController {
  UserRepo userRepo = Get.find<UserRepo>();
  OrderRepo orderRepo = Get.find<OrderRepo>();

  RxList<ProductOrder> productOrders = <ProductOrder>[].obs;

  final uuid = const Uuid();

  List<Partner> get partners => List.generate(
        10,
        (index) => Partner(
          id: uuid.v4(),
          name: "Partner $index",
          location: Location(place: "Location $index"),
        ),
      );

  List<Product> get products => List.generate(
        10,
        (index) => Product(
          id: uuid.v4(),
          name: "Product  $index",
          unit: "Kilogram",
          price: 5000,
        ),
      );

  @override
  void onInit() async {
    super.onInit();
    final streamLocalProductOrders = orderRepo.exposeLocalProductOrders();
    streamLocalProductOrders.listen((data) {
      if (data != null) {
        productOrders.value = data;
      }
    });

    orderRepo.updateLocalProductOrders(
      List.generate(
        5,
        (index) => ProductOrder(
          quantity: (index + 1),
          totalPrice: (index + 1) * 5000,
          product: Product(
            id: uuid.v4(),
            name: "Product ${(index + 1)}",
            price: 5000,
            weight: 1000,
            unit: "Porsi",
          ),
        ),
      ),
    );
  }
}
