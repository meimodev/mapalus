import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/data/repo/product_repo.dart';
import 'package:mapalus/data/repo/user_repo.dart';
import 'package:mapalus/shared/enums.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/utils.dart';

class HomeController extends GetxController {
  UserRepo userRepo = Get.find<UserRepo>();
  OrderRepo orderRepo = Get.find<OrderRepo>();
  ProductRepo productRepo = Get.find<ProductRepo>();

  RxBool isCardCartVisible = false.obs;
  RxBool isCardOrderVisible = false.obs;

  RxString totalPrice = "".obs;
  RxString cartOverview = "".obs;

  RxList<ProductOrder> productOrders = RxList([]);

  Order? latestOrder;
  RxInt unfinishedOrderCount = 0.obs;

  var scrollControllerMain = ScrollController();

  var isLoadingProducts = false.obs;
  var isNoMoreProductsToDisplay = false.obs;
  var displayProducts = <Product>[].obs;

  var tempProducts = <Product>[];
  var tempSearchedProducts = <Product>[];

  var isSearchingProduct = false.obs;

  var tec = TextEditingController();
  final _pageSize = 4;
  var _currentIndex = 0;

  @override
  void onInit() {
    _initProductsDisplay();
    _initNotificationHandler();
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(2.seconds).then((value) => checkNewlyCreatedOrder());

    super.onReady();
  }

  void onPressedLogo() {
    Get.toNamed(Routes.accountSetting, arguments: unfinishedOrderCount.value);
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

  _initProductsDisplay() async {
    isLoadingProducts.value = true;

    tempProducts = await productRepo.getProducts();
    tempSearchedProducts = List.from(tempProducts);
    displayProducts.value = tempProducts.sublist(0, _pageSize);
    _currentIndex += _pageSize;

    scrollControllerMain.addListener(() async {
      if (isNoMoreProductsToDisplay.isTrue) {
        return;
      }

      if (scrollControllerMain.position.maxScrollExtent ==
          scrollControllerMain.offset) {
        if ((_currentIndex + _pageSize) < tempProducts.length) {
          isLoadingProducts.value = true;
          await Future.delayed(500.milliseconds);
          displayProducts.addAll(
            tempProducts.sublist(_currentIndex, _currentIndex + _pageSize),
          );
          isLoadingProducts.value = false;
          _currentIndex += _pageSize;
        } else {
          isLoadingProducts.value = true;
          await Future.delayed(500.milliseconds);
          displayProducts.addAll(tempProducts.sublist(_currentIndex));
          isLoadingProducts.value = false;
          isNoMoreProductsToDisplay.value = true;
        }
      }
    });
    isLoadingProducts.value = false;
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

  _initNotificationHandler() async {
    const androidChannel = AndroidNotificationChannel(
      'order_channel', // id
      'order channel',
      description: 'used to handle order notification exclusively',
      importance: Importance.max,
      enableVibration: true,
      enableLights: true,
      playSound: true,
      showBadge: true,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(
        message: initialMessage,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        androidChannel: androidChannel,
      );
    }
    FirebaseMessaging.onMessage.listen((event) {
      _handleMessage(
        message: event,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        androidChannel: androidChannel,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _handleMessage(
        message: event,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        androidChannel: androidChannel,
      );
    });
  }

  _handleMessage({
    required RemoteMessage message,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    AndroidNotificationChannel? androidChannel,
  }) {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      AndroidNotification? android = notification.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel!.id,
              androidChannel.name,
              channelDescription: androidChannel.description,
              playSound: androidChannel.playSound,
              enableLights: androidChannel.enableLights,
              enableVibration: androidChannel.enableVibration,
            ),
          ),
        );
        return;
      }

      Get.rawSnackbar(
        message: notification.title,
      );
    }
  }

  void onTapSearchText() {
    scrollControllerMain.animateTo(
      275.h,
      duration: 1.seconds,
      curve: Curves.easeInOut,
    );
  }

  onSubmittedSearchText(String value) {}

  onChangedSearchText(String text) {
    var _products = List<Product>.from(tempSearchedProducts);
    if (text.length > 1) {
      //separate the product that contain the text in product name to new list
      //update display list to this new list
      //
      var _searched = _products.where(
        (element) {
          bool isContainName = element.name
              .toLowerCase()
              .trim()
              .contains(text.toLowerCase().trim());
          bool isContainCategory = element.category
              .toLowerCase()
              .trim()
              .contains(text.toLowerCase().trim());
          return isContainName || isContainCategory;
        },
      ).toList();
      tempProducts = _searched;
      //set only the initial products (because infinite scrolling)

      _currentIndex = 0;
      if (tempProducts.length > _pageSize) {
        displayProducts.value = tempProducts.sublist(0, _pageSize);
        _currentIndex += _pageSize;
      } else {
        displayProducts.value = tempProducts;
        _currentIndex += tempProducts.length;
      }
    } else {
      _currentIndex = 0;
      tempProducts = List<Product>.from(tempSearchedProducts);
      displayProducts.clear();

      if (tempProducts.length > _pageSize) {
        displayProducts.value = tempProducts.sublist(0, _pageSize);
        _currentIndex += _pageSize;
        isNoMoreProductsToDisplay.value = false;
        // isLoadingProducts.value = true;
      } else {
        displayProducts.value = tempProducts;
        _currentIndex += tempProducts.length;
      }
    }
  }
}