import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/utils.dart';
import 'dart:developer' as dev;

class CartController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  late RxList<ProductOrder> productOrders;
  late RxBool isCardCartVisible;
  var count = "".obs;
  var weight = "".obs;
  var price = "".obs;

  var note = "".obs;

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

  void onPressedSetDelivery() {
    final data = {
      'products_count': _count,
      'products_price': _price,
      'products_weight': _weight,
      'product_orders': productOrders,
      'note': note.value,
    };
    dev.log(data.toString());
    Get.toNamed(Routes.location, arguments: data);
  }

  _calculateInfo() {
    for (var element in productOrders) {
      _count++;
      _weight += element.quantity * element.product.weight;
      _price += element.totalPrice;
    }
    count.value = "$_count Produk";
    weight.value = "± ${(_weight / 1000).ceil()} Kg";
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

  onChangedNote(String note) {
    this.note.value = note;
  }
}
