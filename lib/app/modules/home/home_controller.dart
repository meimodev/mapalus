import 'package:get/get.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/utils.dart';

class HomeController extends GetxController {
  UserRepo userRepo = Get.find<UserRepo>();

  RxBool isCardCartVisible = false.obs;
  RxBool isCardOrderVisible = false.obs;

  RxString totalPrice = "".obs;
  RxString cartOverview = "".obs;

  RxList<ProductOrder> productOrders = RxList([]);

  void onPressedLogo() {
    Get.toNamed(Routes.accountSetting);
  }

  void onPressedLatestOrder() {
    Get.toNamed(Routes.orders);
  }

  void onPressedCart() async {
    UserApp? user = await userRepo.readSignedInUser();
    if (user == null) {
      Get.toNamed(
        Routes.signing,
        arguments: "Silahkan masuk untuk melanjutkan",
      );
      return;
    }

    print(user.toString());
    Get.toNamed(Routes.cart);
  }

  void onPressedAddToCart(ProductOrder productOrder) {
    ProductOrder? exist = productOrders
        .firstWhereOrNull((element) => element.product == productOrder.product);
    if (exist != null) {
      int index = productOrders.value.indexOf(exist);
      productOrders.value[index].quantity += productOrder.quantity;
      productOrders.value[index].totalPrice +=
          productOrder.quantity * productOrder.product.price;

      var quantity = productOrder.quantity.toString().contains(".00")
          ? productOrder.quantity.toString().replaceFirst('.00', '')
          : productOrder.quantity.toString();

      Get.snackbar(
        "Produk sudah ada dalam keranjang",
        "Berhasil menambahkan $quantity ${productOrder.product.unit}",
        snackPosition: SnackPosition.TOP,
      );

      _calculateCartData();
      return;
    }

    productOrders.value.add(productOrder);
    isCardCartVisible.value = true;
    _calculateCartData();
  }

  void onPressedDeleteItemFromCart(ProductOrder productOrder) {
    productOrders.value.remove(productOrder);
    _calculateCartData();
  }

  void onSignedInUser(UserApp user) {
    print(user.toString());
    Get.toNamed(Routes.cart);
  }

  _calculateCartData() {
    double total = 0;
    int count = 0;
    double weight = 0;
    for (var e in productOrders) {
      total += e.totalPrice;
      count++;
      weight += e.quantity;
    }
    totalPrice.value = Utils.formatNumberToCurrency(total);
    cartOverview.value = "$count Produk, $weight Kilogram";
    if (count == 0) {
      isCardCartVisible.value = false;
    }
  }
}