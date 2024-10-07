import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:uuid/uuid.dart';

class OrderSummaryController extends GetxController {
  OrderRepo orderRepo = Get.find<OrderRepo>();
  AppRepo appRepo = Get.find<AppRepo>();
  PartnerRepo partnerRepo = Get.find<PartnerRepo>();
  UserRepo userRepo = Get.find<UserRepo>();

  List<ProductOrder> products = [];
  Partner? partner;

  RxBool selectionLoading = false.obs;

  Location? deliveryLocation;

  DeliveryTime? deliveryTime;
  String? deliveryTimeText;

  PaymentMethod? paymentMethod;
  String? paymentMethodText;

  Voucher? voucher;

  Rx<bool> enableMainButton = false.obs;

  DeliveryModifiers? modifiers;

  double? distance;

  @override
  void onInit() async {
    super.onInit();

    selectionLoading.value = true;
    products = await orderRepo.readLocalProductOrders();
    partner = await partnerRepo.readPartner(products.first.product.partnerId);
    modifiers = await appRepo.getDeliveryModifiers();

    UserApp? user = userRepo.signedUser;
    print("user $user");
    selectionLoading.value = false;
  }

  ///[INFO] Result in gram
  double get getProductWeight {
    if (products.isEmpty) return 0;
    return products
        .reduce(
          (value, element) => value.copyWith(
            totalPrice: (value.quantity * value.product.weight) +
                (element.quantity * element.product.weight),
          ),
        )
        .totalPrice;
  }

  double get getProductPrices {
    if (products.isEmpty) return 0;
    return products
        .reduce(
          (value, element) => value.copyWith(
            totalPrice: value.totalPrice + element.totalPrice,
          ),
        )
        .totalPrice;
  }

  double get getDiscountedValue {
    if (voucher == null) {
      return 0;
    }
    return getProductPrices * voucher!.discount;
  }

  double get getDeliveryFee {
    if (deliveryLocation == null ||
        modifiers == null ||
        partner == null ||
        getProductWeight == 0) {
      return 0;
    }
    final origin = partner!.location!;
    final destination = deliveryLocation!;
    distance = Utils.calculateDistance(
      originLatitude: origin.latitude,
      originLongitude: origin.longitude,
      destinationLatitude: destination.latitude,
      destinationLongitude: destination.longitude,
    );

    return orderRepo.calculateDeliveryFee(
      distance!,
      modifiers!,
      getProductWeight,
    );
  }

  double get getTotal =>
      (getProductPrices + getDeliveryFee) - getDiscountedValue;

  void onSelectedDeliveryLocation(Location location) {
    selectionLoading.value = true;
    deliveryLocation = location;
    selectionLoading.value = false;
    calculateOutputs();
  }

  void onSelectedVoucher(Voucher value) {
    selectionLoading.value = true;
    voucher = value;
    selectionLoading.value = false;
    calculateOutputs();
  }

  void onSelectedPayment(PaymentMethod value, String title) {
    selectionLoading.value = true;
    paymentMethod = value;
    paymentMethodText = title;
    selectionLoading.value = false;
    calculateOutputs();
  }

  void onSelectedDeliveryTime(DeliveryTime value, String title) {
    selectionLoading.value = true;
    deliveryTime = value;
    deliveryTimeText = title;
    selectionLoading.value = false;
    calculateOutputs();
  }

  void calculateOutputs() {
    if (deliveryLocation != null &&
        deliveryTime != null &&
        paymentMethod != null) {
      enableMainButton.value = true;
    }
  }

  void onPressedMakeOrder() async {
    selectionLoading.value = true;
    const uuid = Uuid();
    final orderId = uuid.v4();
    final order = OrderApp(
      id: orderId,
      status: OrderStatus.placed,
      lastUpdate: DateTime.now(),
      createdAt: DateTime.now(),
      orderBy: userRepo.signedUser!,
      partnerId: products.first.product.partnerId,
      payment: Payment(
        id: uuid.v4(),
        orderId: orderId,
        method: paymentMethod!,
        status: PaymentStatus.placed,
        lastUpdate: DateTime.now(),
        amount: getTotal,
        createdAt: DateTime.now(),
      ),
      note: await orderRepo.readLocalNote(),
      products: products,
      delivery: OrderDelivery(
        id: uuid.v4(),
        orderId: orderId,
        weight: getProductWeight,
        price: getDeliveryFee,
        distance: distance!,
        status: DeliveryStatus.placed,
        selectedTime: deliveryTime!,
        lastUpdate: DateTime.now(),
        destination: deliveryLocation!,
        deliverBy: null,
        selectedDate: DateTime.now(),
      ),
      voucher: voucher,
    );

    selectionLoading.value = false;

    Get.until(ModalRoute.withName(Routes.home));
    Get.toNamed(Routes.ordering, arguments: order.toJson());
  }
}
