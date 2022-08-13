import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mapalus/data/models/delivery_info.dart';
import 'package:mapalus/data/models/order_info.dart';
import 'package:mapalus/data/models/product_order.dart';
import 'package:mapalus/data/repo/app_repo.dart';
import 'package:mapalus/data/repo/location_repo.dart';
import 'package:mapalus/data/repo/order_repo.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus/shared/utils.dart';

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
    deliveryCoordinate: const LatLng(0, 0),
  ).obs;

  RxDouble distance = 0.0.obs;
  RxDouble weight = 2.0.obs;

  DeliveryInfo? _selectedDeliveryInfo;

  late RxList<DeliveryInfo> deliveries;

  OrderRepo orderRepo = Get.find<OrderRepo>();

  LatLng? deliveryCoordinate;

  // LatLng? currentLocation;

  RxBool isLocationNoteEnabled = false.obs;
  GoogleMapController? googleMapController;

  @override
  void onInit() async {
    super.onInit();

    var d = await appRepo.getDeliveryTimes();
    deliveries = d.map((e) => DeliveryInfo.fromJSON(e)).toList().obs;

    var args = Get.arguments;
    double w = double.parse(args['products_weight'].toString());
    orderInfo.value = orderInfo.value.copyWith(
      productCount: int.parse(args['products_count'].toString()),
      productPrice: double.parse(args['products_price'].toString()),
      deliveryWeight: w,
    );
    weight.value = w;
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
      LatLng pos1 =
          const LatLng(1.3019081307317848, 124.9068409438052); //pasar Tondano
      double dis = Utils.calculateDistance(pos1, deliveryCoordinate!);
      distance.value = Utils.roundDouble(dis, 2);
      _calculateOrderInfo();
      // print('Distance = ' + distance.value.toString());
    }
  }

  onPressedMakeOrder() async {
    if (_selectedDeliveryInfo == null) {
      Get.snackbar("Perhatian !", "Waktu pengataran belum dipilih");
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
    Get.toNamed(
      Routes.ordering,
      arguments: <String, dynamic>{
        'delivery_info': _selectedDeliveryInfo,
        'product_orders': productOrders,
        'order_info': orderInfo.value,
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
      deliveryCoordinate: deliveryCoordinate,
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
      return ;
    }
    var locationPermissionGranted =
        await locationRepo.isLocationPermissionGranted();

    if (!locationPermissionGranted) {
      var granted = await locationRepo.requestLocationPermission();
      if (!granted) {
        return ;
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
        googleMapController!
            .animateCamera(CameraUpdate.newLatLng(currLocation));

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
