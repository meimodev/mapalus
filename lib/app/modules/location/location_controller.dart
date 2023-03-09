import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus/shared/routes.dart';
import 'dart:developer' as dev;

class LocationController extends GetxController {
  AppRepo appRepo = Get.find();

  RxBool isLocationSelectionVisible = true.obs;
  RxBool isLocationSelectionButtonVisible = true.obs;

  LocationRepoContract locationRepo = LocationRepo.instance;

  Rx<OrderInfo> orderInfo = OrderInfo(
    productCount: 0,
    productPrice: 0,
    deliveryWeight: 0,
    deliveryPrice: 0,
    deliveryDistance: 0,
    deliveryCoordinateLatitude: 0,
    deliveryCoordinateLongitude: 0,
  ).obs;

  RxDouble distance = 0.0.obs;
  RxDouble weight = 2.0.obs;

  DeliveryInfo? _selectedDeliveryInfo;

  RxList<DeliveryInfo> deliveries = <DeliveryInfo>[].obs;

  OrderRepo orderRepo = Get.find<OrderRepo>();

  LatLng? deliveryCoordinate;

  // LatLng? currentLocation;

  RxBool isLocationNoteEnabled = false.obs;
  GoogleMapController? googleMapController;

  RxBool isLoading = true.obs;

  var paymentMethodSubTittle = "".obs;

  int? paymentMoneyAmount;

  int paymentSelectedIndex = 0;

  String note = "";

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    //fetch pricing modifier then fetch delivery times
    final pm = await appRepo.getPricingModifier();
    PricingModifier pricingModifier = PricingModifier.fromJson(pm);
    var d = await appRepo.getDeliveryTimes();
    //set the pricing modifier to each dDeliveryInfo object
    deliveries = d
        .map((e) {
          e.addAll(pricingModifier.toMap);
          dev.log("Delivery info => $e");
          return DeliveryInfo.fromJSON(e);
        })
        .toList()
        .obs;

    isLoading.value = false;

    //fetch delivery fees
    var args = Get.arguments;
    double w = double.parse(args['products_weight'].toString());
    orderInfo.value = orderInfo.value.copyWith(
      productCount: int.parse(args['products_count'].toString()),
      productPrice: double.parse(args['products_price'].toString()),
      deliveryWeight: w,
    );
    weight.value = w;
    note = args['note'] ?? '';
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

  onPressedSelectLocation() async {
    isLocationSelectionVisible.toggle();
    if (isLocationNoteEnabled.isTrue) {
      isLocationNoteEnabled.toggle();
    }

    //calculate the prices
    if (isLocationSelectionVisible.isFalse) {

      ///pasar tondano coordinate
      LatLng pos1 = const LatLng(1.3019081307317848, 124.9068409438052);
      double dis = Utils.calculateDistance(
        pos1Latitude: pos1.latitude,
        pos1Longitude: pos1.longitude,
        pos2Latitude: deliveryCoordinate!.latitude,
        pos2Longitude: deliveryCoordinate!.longitude,
      );
      distance.value = Utils.roundDouble(dis, 2);
      _calculateOrderInfo();
    }
  }

  onPressedMakeOrder() async {
    if (_selectedDeliveryInfo == null) {
      Get.rawSnackbar(title:"Perhatian !", message: "Waktu pengataran belum dipilih");
      return;
    }

    var deliveryTime = _selectedDeliveryInfo!.title;
    if (_selectedDeliveryInfo!.isTomorrow) {
      final tomorrowDate = Jiffy().add(days: 1).format("EEEE, dd MMM");
      orderInfo.value.deliveryTime = "$deliveryTime ($tomorrowDate)";
    } else {
      orderInfo.value.deliveryTime = deliveryTime;
    }

    List<ProductOrder> productOrders = (Get.arguments
        as Map<String, dynamic>)['product_orders'] as List<ProductOrder>;

    ///TODO replace with more appropriate implementation next iteration, use enums instead of 'index'
    final paymentMethodString = paymentSelectedIndex == 0 ? 'CASH' : 'CASHLESS';

    Get.toNamed(
      Routes.ordering,
      arguments: <String, dynamic>{
        'delivery_info': _selectedDeliveryInfo,
        'product_orders': productOrders,
        'order_info': orderInfo.value,
        'payment_method': paymentMethodString,
        'payment_amount': paymentMoneyAmount ?? 0,
        'note': note,
      },
    );
  }

  onPressedChangeLocation() async {
    isLocationSelectionVisible.toggle();
    isLocationNoteEnabled.toggle();
    _selectedDeliveryInfo = null;
  }

  onCameraIdle(LatLng? pos) {
    deliveryCoordinate = pos;
    if (pos == null) {
      isLocationSelectionButtonVisible.value = false;
    } else {
      isLocationSelectionButtonVisible.value = true;
    }
  }

  Future<bool> onPressedBackButton() {
    if (isLocationSelectionVisible.isFalse) {
      isLocationSelectionVisible.toggle();
      _selectedDeliveryInfo = null;
      return Future.value(false);
    }
    return Future.value(true);
  }

  _calculateOrderInfo() {
    orderInfo.value = orderInfo.value.copyWith(
      deliveryWeight: weight.value,
      deliveryDistance: distance.value,
      deliveryCoordinateLatitude: deliveryCoordinate?.latitude,
      deliveryCoordinateLongitude: deliveryCoordinate?.longitude,
    );
  }

  onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    initLocation();
  }

  void initLocation() async {
    var locationEnabled = await locationRepo.isLocationServicesEnabled();
    if (!locationEnabled) {
      isLocationNoteEnabled.value = true;
      return;
    }
    var locationPermissionGranted =
        await locationRepo.isLocationPermissionGranted();

    if (!locationPermissionGranted) {
      var granted = await locationRepo.requestLocationPermission();
      if (!granted) {
        return;
      }
      initLocation();
      return;
    }
    // try {
    await Future.delayed(1.seconds);
    LatLng currLocation = LatLng(
      await locationRepo.getDeviceLatitude(),
      await locationRepo.getDeviceLongitude(),
    );
    googleMapController!.animateCamera(CameraUpdate.newLatLng(currLocation));

    if (isLocationNoteEnabled.isTrue) {
      isLocationNoteEnabled.toggle();
    }
    // } catch (e) {
    //   debugPrint('Error While getting current location ${e.toString()}');
    // }
  }

  onPressedLocationErrorNote() async {
    initLocation();
  }
}
