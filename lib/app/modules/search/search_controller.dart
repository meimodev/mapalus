import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class SearchController extends GetxController {
  RxList<ProductOrder> productOrders = <ProductOrder>[].obs;
  RxBool loading = true.obs;

  final orderRepo = Get.find<OrderRepo>();
  final productRepo = Get.find<ProductRepo>();

  List<Product> products = [];
  List<Product> tempProducts = [];

  Debounce debounce = Debounce(const Duration(milliseconds: 240));

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

    //TODO temporary solution for product searching
    tempProducts = await productRepo.readProducts(const GetProductRequest());

    if (args == null) {
      products = tempProducts;
    }

    loading.value = false;
  }

  void onChangedSearchText(String value) {
    debounce.call(() async {
      loading.value = true;
      await Future.delayed(const Duration(milliseconds: 400));
      final products = tempProducts.where(
        (element) => element.name.toLowerCase().contains(value.toLowerCase()),
      );
      this.products = products.toList();
      loading.value = false;
    });
  }

  void onSubmittedSearchText(String value) {}
}
