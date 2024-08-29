import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class SearchController extends GetxController {
  RxList<ProductOrder> productOrders = <ProductOrder>[].obs;
  RxBool loading = true.obs;

  final orderRepo = Get.find<OrderRepo>();
  final productRepo = Get.find<ProductRepo>();

  List<Product> products = [];

  @override
  void onInit() async {
    super.onInit();

    final streamLocalProductOrders = orderRepo.exposeLocalProductOrders();
    streamLocalProductOrders.listen((data) {
      if (data != null) {
        productOrders.value = data;
      }
    });



    final args = Get.arguments;
    if (args != null) {
      final partnerId = args as String;
      final products = await productRepo.readProducts(
        GetProductRequest(partnerId: partnerId),
      );
      this.products = products;
    }

    loading.value = false;
  }
}
