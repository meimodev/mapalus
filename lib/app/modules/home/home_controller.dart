
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/dialog_announcement.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus/shared/routes.dart';
import 'dart:developer' as dev;

class HomeController extends GetxController {
  UserRepo userRepo = Get.find<UserRepo>();
  OrderRepo orderRepo = Get.find<OrderRepo>();
  ProductRepo productRepo = Get.find<ProductRepo>();
  AppRepo appRepo = Get.find<AppRepo>();

  RxBool isCardCartVisible = false.obs;
  RxBool isCardOrderVisible = false.obs;

  RxString totalPrice = "".obs;
  RxString cartOverview = "".obs;

  RxList<ProductOrder> productOrders = RxList([]);

  OrderApp? latestOrder;
  RxInt unfinishedOrderCount = 0.obs;

  var scrollControllerMain = ScrollController();

  var canLoadingProducts = false.obs;
  var canLoadingMain = true.obs;
  var isNoMoreProductsToDisplay = false.obs;
  var displayProducts = <Product>[].obs;

  var tempProducts = <Product>[];
  var tempSearchedProducts = <Product>[];

  var isSearchingProduct = false.obs;

  TextEditingController tecSearch = TextEditingController();
  final _pageSize = 10;
  var _currentIndex = 0;

  RxList<Category> categories = [
    Category(
      name: "Bahan Makanan",
      imageUrl: "https://i.ibb.co/mJmZQkW/category-bahan-makanan.jpg",
      asset: "assets/images/category-bahan-makanan.jpeg",
    ),
    Category(
      name: "Lauk Pauk",
      imageUrl: "https://i.ibb.co/LgdQZXS/category-lauk-pauk.jpg",
      asset: "assets/images/category-lauk-pauk.jpeg",
    ),
    Category(
        name: "Bumbu Dapur",
        imageUrl: "https://i.ibb.co/HhgsbGZ/category-bumbu-dapur.jpg",
        asset: "assets/images/category-bumbu-dapur.jpeg"),
    Category(
        name: "Sayuran",
        imageUrl: "https://i.ibb.co/M5jXDRG/category-sayuran.jpg",
        asset: "assets/images/category-sayuran.jpeg"),
    Category(
        name: "Buah",
        imageUrl: "https://i.ibb.co/cc7QcY6/category-buah.jpg",
        asset: "assets/images/category-buah.jpeg"),
    Category(
        name: "Bahan Kue",
        imageUrl: "https://i.ibb.co/3M4jN9F/category-bahan-kue.jpg",
        asset: "assets/images/category-bahan-kue.jpeg"),
    Category(
        name: "Paket Hemat",
        imageUrl: "https://i.ibb.co/CHLm43X/category-paket.jpg",
        asset: "assets/images/category-paket.jpg"),
  ].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    categories.shuffle();
    await Future.delayed(Duration.zero);

    await _initProductsDisplay();

    await Future.delayed(const Duration(seconds: 1));
    if (!await appRepo.checkIfLatestVersion(true)) {
      Get.offNamed(Routes.updateApp);
      return;
    }
    await Future.delayed(Duration.zero);
    await checkAnnouncement();
    await checkNewlyCreatedOrder();

    _initNotificationHandler();
  }

  @override
  void dispose() {
    tecSearch.dispose();
    super.dispose();
  }

  void onPressedLogo() {
    Get.toNamed(Routes.accountSetting, arguments: unfinishedOrderCount.value);
  }

  void onPressedLatestOrder() {
    if (isCardOrderVisible.isTrue && latestOrder != null) {
      Get.toNamed(Routes.orderDetail, arguments: latestOrder, parameters: {
        'refresh': "true",
      });
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

  Future<void> _initProductsDisplay() async {
    canLoadingMain.value = true;

    // canLoadingProducts.value = true;

    tempProducts = await productRepo.readProducts();
    tempProducts.shuffle();
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
          canLoadingProducts.value = true;
          await Future.delayed(Duration.zero);
          displayProducts.addAll(
            tempProducts.sublist(_currentIndex, _currentIndex + _pageSize),
          );
          canLoadingProducts.value = false;
          _currentIndex += _pageSize;
        } else {
          canLoadingProducts.value = true;
          await Future.delayed(Duration.zero);
          displayProducts.addAll(tempProducts.sublist(_currentIndex));
          canLoadingProducts.value = false;
          isNoMoreProductsToDisplay.value = true;
        }
      }
    });
    await Future.delayed(Duration.zero);
    canLoadingMain.value = false;

    // canLoadingProducts.value = false;
  }

  orderCleanUp() async {
    productOrders.clear();
    isCardCartVisible.value = false;

    await checkNewlyCreatedOrder();
  }

  Future<void> checkNewlyCreatedOrder() async {
    if (userRepo.signedUser == null) {
      isCardOrderVisible.value = false;
      return;
    }
    if (userRepo.signedUser!.orders.isEmpty) {
      return;
    }

    final oo = userRepo.signedUser!.orders;
    final latestOrderId = oo.elementAt(oo.length - 1);

    //get the unfinished order count
    unfinishedOrderCount.value = oo.length;

    // get the latest order
    final o = await orderRepo.readOrder(latestOrderId);
    if (o == null) {
      return;
    }
    // check if order is not finish, then display it
    if (o.status != OrderStatus.finished) {
      latestOrder = o;
      isCardOrderVisible.value = true;
    }
  }

  _initNotificationHandler() async {
    const androidChannel = AndroidNotificationChannel(
      'order_channel', // id
      'order channel',
      description: 'used to handle order notification exclusively',
      importance: Importance.high,
      enableVibration: true,
      enableLights: true,
      playSound: true,
      showBadge: true,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        dev.log("notification payload ${response.payload}");
      },
    );

    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(androidChannel);

    // final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    // if (initialMessage != null) {
    //   _handleMessage(
    //     message: initialMessage,
    //     flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
    //     androidChannel: androidChannel,
    //   );
    // }

    FirebaseMessaging.onMessage.listen((event) {
      _handleMessage(
        message: event,
        flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        androidChannel: androidChannel,
      );
    });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   _handleMessage(
    //     message: event,
    //     flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
    //     androidChannel: androidChannel,
    //   );
    // });
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
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          androidChannel!.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          enableVibration: true,
          enableLights: true,
        );

        NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);

        //show

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          notificationDetails,
        );
        return;
      }
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

  onChangedSearchText(String text) async {
    canLoadingMain.value = true;
    var pp = List<Product>.from(tempSearchedProducts);
    isNoMoreProductsToDisplay.value = false;

    if (text.length > 1) {
      //separate the product that contain the text in product name to new list
      //update display list to this new list
      //
      var searched = pp.where(
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
      tempProducts = searched;
      //set only the initial products (because infinite scrolling)

      _currentIndex = 0;
      if (tempProducts.length > _pageSize) {
        displayProducts.value = tempProducts.sublist(0, _pageSize);
        _currentIndex += _pageSize;
      } else {
        displayProducts.value = tempProducts;
        _currentIndex += tempProducts.length;
        isNoMoreProductsToDisplay.value = true;
      }
    } else {
      _currentIndex = 0;
      tempProducts = List<Product>.from(tempSearchedProducts);
      displayProducts.clear();

      if (tempProducts.length > _pageSize) {
        displayProducts.value = tempProducts.sublist(0, _pageSize);
        _currentIndex += _pageSize;
        // isLoadingProducts.value = true;
      } else {
        displayProducts.value = tempProducts;
        _currentIndex += tempProducts.length;
        isNoMoreProductsToDisplay.value = true;
      }
    }
    await Future.delayed(1.seconds);
    canLoadingMain.value = false;
  }

  onPressedCategories(Category category) {
    tecSearch.text = category.name;
    onChangedSearchText(category.name);
  }

  void seeRecentOrder() {
    if (isCardOrderVisible.isTrue && latestOrder != null) {
      Get.toNamed(Routes.orderDetail, arguments: latestOrder);
    }
    orderCleanUp();
  }

  Future<void> checkAnnouncement() async {
    final announcement = await appRepo.getAppAnnouncement();
    if (announcement == null) {
      return;
    }
    if (!announcement.activated) {
      return;
    }
    Get.dialog(DialogAnnouncement(announcement: announcement));
  }
}
