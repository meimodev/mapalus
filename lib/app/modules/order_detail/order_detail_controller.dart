import 'dart:async';

import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home_controller.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class OrderDetailController extends GetxController {
  OrderRepo orderRepo = Get.find();
  HomeController homeController = Get.find();

  RxList<ProductOrder> productOrdersChecked = <ProductOrder>[].obs;

  RxString totalCheckedPrice = ''.obs;

  late Rx<OrderApp> order;

  RxBool isLoading = true.obs;

  UserApp? orderingUser;

  late StreamSubscription orderListener;

  @override
  Future<void> onInit() async {
    super.onInit();

    isLoading.value = true;
    OrderApp o = Get.arguments as OrderApp;
    order = o.obs;

    orderListener =
        orderRepo.firestore.getOrderStream(o.id!).listen((snapshot) {
      isLoading.value = true;

      final t = OrderApp.fromMap(snapshot.data() as Map<String, dynamic>);
      order = t.obs;

      if (isLoading.isTrue) {
        isLoading.value = false;
      }
    });

    isLoading.value = false;
  }

  @override
  void dispose() {
    orderListener.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    homeController.checkNewlyCreatedOrder();
    super.onClose();
  }

  Future<void> onPressedRate(String message, double rate) async {
    isLoading.value = true;
    Future.delayed(800.milliseconds);
    var rating = Rating(
      rate.ceil(),
      message,
    );
    await orderRepo.rateOrder(order.value, rating);

    isLoading.value = false;
  }

  void onPressedCancel() {
    const waNumber = '+62895355578090';
    final orderId = order.value.id!;
    final waUri = Uri.parse('whatsapp://send?phone=$waNumber&text='
        'Halo admin MAPALUS, tolong batalkan pesanan $orderId karena: ');
    launchUrl(waUri);
  }

  onPressedViewMaps() {
    var latitude = order.value.orderInfo.deliveryCoordinateLatitude;
    var longitude = order.value.orderInfo.deliveryCoordinateLongitude;
    var url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    // ignore: deprecated_member_use
    launch(url);
  }
}
