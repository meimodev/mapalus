import 'package:get/get.dart';
import 'package:mapalus/data/models/data_mock.dart';
import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/data/models/order_info.dart';
import 'package:mapalus/data/models/product.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/shared/routes.dart';

class LocationController extends GetxController {
  RxBool isLocationSelectionVisible = true.obs;

  Rx<OrderInfo> orderInfo = OrderInfo(
    productCount: 2,
    productPrice: 5000,
    deliveryWeight: 1.5,
    deliveryPrice: 10000,
    deliveryDistance: 1,
  ).obs;

  RxDouble distance = 2.0.obs;
  RxDouble weight = 2.0.obs;

  DeliveryInfo? _selectedDeliveryInfo;

  RxList<DeliveryInfo> deliveries = DataMock.deliveries
      .map(
        (e) => DeliveryInfo.fromJSON(e),
      )
      .toList()
      .obs;

  OrderRepo orderRepo = OrderRepo();

  @override
  void onInit() {
    super.onInit();

    var args = Get.arguments;
    double _weight = double.parse(args['products_weight'].toString());
    orderInfo.value = orderInfo.value.copyWith(
      productCount: int.parse(args['products_count'].toString()),
      productPrice: double.parse(args['products_price'].toString()),
      deliveryWeight: _weight,
    );
    weight.value = _weight;
    _calculateOrderInfo();
  }

  onPressedChangeDeliveryTime(
    DeliveryInfo deliveryInfo,
    double price,
  ) {
    _selectedDeliveryInfo = deliveryInfo;
    orderInfo.value = orderInfo.value.copyWith(
      deliveryPrice: price,
      deliveryWeight: weight.value / 1000,
      deliveryDistance: distance.value,
    );
  }

  onPressedSelectLocation() {
    isLocationSelectionVisible.toggle();
  }

  onPressedMakeOrder() async {
    if (_selectedDeliveryInfo == null) {
      Get.snackbar("Perhatian !", "Waktu pengataran belum dipilih");
      return;
    }

    List<ProductOrder> _productOrders = (Get.arguments
        as Map<String, dynamic>)['product_orders'] as List<ProductOrder>;
    Get.toNamed(
      Routes.ordering,
      arguments: <String, dynamic>{
        'delivery_info': _selectedDeliveryInfo,
        'product_orders': _productOrders,
      },
    );
  }

  onPressedChangeLocation() {
    isLocationSelectionVisible.toggle();
  }

  _calculateOrderInfo() {
    orderInfo.value = orderInfo.value.copyWith(
      deliveryWeight: weight.value,
      deliveryDistance: distance.value,
    );
  }
}