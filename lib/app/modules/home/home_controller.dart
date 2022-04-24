import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mapalus/data/models/data_mock.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/utils.dart';

class HomeController extends GetxController {
  UserRepo userRepo = Get.find<UserRepo>();
  OrderRepo orderRepo = Get.find<OrderRepo>();

  RxBool isCardCartVisible = false.obs;
  RxBool isCardOrderVisible = false.obs;

  RxString totalPrice = "".obs;
  RxString cartOverview = "".obs;

  RxList<ProductOrder> productOrders = RxList([]);

  Order? latestOrder;
  RxInt unfinishedOrderCount = 0.obs;

  final PagingController<int, Product> pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void onInit() {
    _initInfiniteScrolling();
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(3.seconds).then((value) => checkNewlyCreatedOrder());

    super.onReady();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void onPressedLogo() {
    Get.toNamed(Routes.accountSetting);
  }

  void onPressedLatestOrder() {
    if (isCardOrderVisible.isTrue && latestOrder != null) {
      Get.toNamed(Routes.orderDetail, arguments: latestOrder);
    }
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

  _initInfiniteScrolling() {
    pagingController.addPageRequestListener((pageKey) {
      print('Page key = $pageKey');
      final _totalItem = DataMock.products.length;
      final productsJson = DataMock.products;
      if ((pageKey + 2) < _totalItem) {
        pagingController.appendPage(
          [
            Product.fromMap(productsJson[0]),
            Product.fromMap(productsJson[1]),
          ],
          pageKey + 2,
        );
        return;
      }
      if ((pageKey + 2) >= _totalItem) {
        pagingController.appendLastPage(
          [
            Product.fromMap(productsJson[0]),
            Product.fromMap(productsJson[1]),
          ],
        );
      }
    });
  }

  orderCleanUp() {
    productOrders.clear();
    isCardCartVisible.value = false;

    checkNewlyCreatedOrder();
  }

  checkNewlyCreatedOrder() async {
    if (userRepo.signedUser == null) {
      return;
    }
    if (userRepo.signedUser!.orders.isEmpty) {
      return;
    }
    final _orders = userRepo.signedUser!.orders;
    final latestOrderId = _orders.elementAt(_orders.length - 1);

    //get the unfinished order count
    unfinishedOrderCount.value = _orders.length;

    // get the latest order
    final _order = await orderRepo.readOrder(latestOrderId);
    if (_order == null) {
      return;
    }
    // check if order is not finish, then display it
    if (_order.status == OrderStatus.placed) {
      latestOrder = _order;
      isCardOrderVisible.value = true;
      // display in card latest order visibility
    } else {
      isCardOrderVisible.value = false;
    }
  }
}