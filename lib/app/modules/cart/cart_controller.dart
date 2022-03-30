import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/utils.dart';

class CartController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  late RxList<ProductOrder> productOrders;
  late RxBool isCardCartVisible;
  var count = "".obs;
  var weight = "".obs;
  var price = "".obs;

  int _count = 0;
  double _weight = 0;
  double _price = 0;

  @override
  void onInit() {
    super.onInit();
    productOrders = RxList.of(homeController.productOrders);
    isCardCartVisible = homeController.isCardCartVisible;
    _calculateInfo();
  }

  // @override
  // void onReady() {
  //   productOrders = homeController.productOrders;
  //   isCardCartVisible = homeController.isCardCartVisible;
  //   _calculateInfo();
  //   print('onready : $productOrders');
  // }

  void onPressedSetDelivery() {
    Get.toNamed(Routes.location, arguments: {
      'products_count': _count,
      'products_price': _price,
      'products_weight': _weight,
      'product_orders': productOrders,
    });
  }

  _calculateInfo() {
    for (var element in productOrders) {
      _count++;
      _weight += element.quantity * element.product.weight;
      _price += element.totalPrice;
    }
    count.value = "$_count Produk";
    weight.value =
        "${(_weight / 1000).toStringAsFixed(2).replaceFirst('.00', '')} Kg";
    price.value = Utils.formatNumberToCurrency(_price);
  }

  void onPressedItemDelete(ProductOrder productOrder) {
    productOrders.remove(productOrder);
    homeController.onPressedDeleteItemFromCart(productOrder);

    if (productOrders.isEmpty) {
      Get.back();
      return;
    }
    _calculateInfo();
  }
}