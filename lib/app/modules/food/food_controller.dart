import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';

class FoodController extends GetxController {
  final orderRepo = Get.find<OrderRepo>();
  final productRepo = Get.find<ProductRepo>();
  final partnerRepo = Get.find<PartnerRepo>();

  RxList<ProductOrder> productOrders = <ProductOrder>[].obs;

  List<Partner> partners = [];
  List<Product> products = [];

  RxBool loading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    final streamLocalProductOrders = orderRepo.exposeLocalProductOrders();
    streamLocalProductOrders.listen((data) {
      if (data != null) {
        productOrders.value = data;
      }
    });

    final initProducts = await orderRepo.readLocalProductOrders();
    if (initProducts.isNotEmpty) {
      productOrders.value = initProducts;
    }

    //TODO fetch partners, later only fetch the one nearest to user
    final partners = await partnerRepo.readPartnersForHome();
    this.partners = partners;

    //TODO fetch products, later only fetch the one nearest to user
    final products = await productRepo.readProducts(const GetProductRequest());
    this.products = products;

    loading.value = false;
  }
}
