import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus/shared/routes.dart';
import 'dart:developer' as dev;

class CartController extends GetxController {
  GroceryController homeController = Get.find<GroceryController>();

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
  Future<void> onInit() async {
    super.onInit();
    productOrders = RxList.of(homeController.productOrders);
    isCardCartVisible = homeController.isCardCartVisible;
    _calculateInfo();
    await homeController.checkAnnouncement();
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
    price.value = _price.formatNumberToCurrency();
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
