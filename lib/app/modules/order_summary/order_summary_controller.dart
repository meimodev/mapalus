import 'package:get/get.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class OrderSummaryController extends GetxController {
  OrderRepo orderRepo = Get.find<OrderRepo>();
  AppRepo appRepo = Get.find<AppRepo>();
  PartnerRepo partnerRepo = Get.find<PartnerRepo>();

  List<ProductOrder> products = [];
  Partner? partner ;

  RxBool selectionLoading = false.obs;

  Location? deliveryLocation;

  DeliveryTime? deliveryTime;
  String? deliveryTimeText;

  PaymentMethod? paymentMethod;
  String? paymentMethodText;

  Voucher? voucher;

  Rx<bool> enableMainButton = false.obs;

  DeliveryModifiers? modifiers;

  @override
  void onInit() async {
    super.onInit();

    selectionLoading.value = true;
    products = await orderRepo.readLocalProductOrders();
    partner = await partnerRepo.readPartner(products.first.product.partnerId);
    modifiers = await appRepo.getDeliveryModifiers();
    selectionLoading.value = false;
  }

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

  //check discount from voucher
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
        getProductWeight == 0 ) {
      return 0;
    }

    return orderRepo.calculateDeliveryFee(
      partner!.location!,
      deliveryLocation!,
      modifiers!,
      getProductWeight,
    );
  }

  double get getTotal =>
      (getProductPrices + getDeliveryFee) - getDiscountedValue;



  void onSelectedDeliveryLocation() {
    selectionLoading.value = true;
    deliveryLocation = const Location(place: "Test Place", );
    selectionLoading.value = false;
    calculateOutputs();
  }

  void onSelectedVoucher(Voucher value) {
    selectionLoading.value = true;
    voucher = value;
    selectionLoading.value = false;
    calculateOutputs();
  }

  void onSelectedPayment(PaymentMethod value) {
    selectionLoading.value = true;
    paymentMethod = value;
    paymentMethodText = value.name.capitalizeFirst;
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

  void onPressedMakeOrder() {
    Get.toNamed(Routes.ordering);
  }
}
