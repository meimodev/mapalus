import 'package:get/get.dart';
import 'package:mapalus/shared/shared.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class SearchController extends GetxController {
  RxList<ProductOrder> productOrders = <ProductOrder>[].obs;

  OrderRepo orderRepo = Get.find<OrderRepo>();

  @override
  void onInit() async {
    super.onInit();

    final streamLocalProductOrders =  orderRepo.exposeLocalProductOrders();
    streamLocalProductOrders.listen((data) {
      if (data != null) {
        productOrders.value = data;
      }
    });

    orderRepo.updateLocalProductOrders([
      ProductOrder(
        product: Product(name: "some name"),
        quantity: 1,
        totalPrice: 5000,
      ),
    ]);
  }

}
