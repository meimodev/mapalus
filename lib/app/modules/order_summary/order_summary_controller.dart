import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class OrderSummaryController extends GetxController {
  OrderRepo orderRepo = Get.find<OrderRepo>();
  List<ProductOrder> products = [];

  RxBool selectionLoading = false.obs;

  Location? deliveryLocation;

  DeliveryTime? deliveryTime;
  String? deliveryTimeText;

  PaymentMethod? paymentMethod;
  String? paymentMethodText;

  Voucher? voucher;

  Rx<bool> enableMainButton = false.obs;

  double get getTotalPrices => products
      .reduce(
        (value, element) => value.copyWith(
          totalPrice: value.totalPrice + element.totalPrice,
        ),
      )
      .totalPrice;

  //check discount from voucher
  double get getDiscountedValue => 1000;

  //check distance to destination and multiply that with app variable
  // + check time of delivery because that might contain discount percentage on each of delivery time
  double get getDeliveryFee => 100;

  double get getFinalTotal => (getTotalPrices+ getDeliveryFee) - getDiscountedValue ;

  @override
  void onInit() async {
    super.onInit();

    selectionLoading.value = true;
    products = await orderRepo.readLocalProductOrders();
    selectionLoading.value = false;
  }

  void onSelectedDeliveryLocation() {
    selectionLoading.value = true;
    deliveryLocation = const Location(place: "Test Place");
    selectionLoading.value = false;
  }

  void onSelectedVoucher(Voucher value) {
    selectionLoading.value = true;
    voucher = const Voucher(
      id: 'id',
      code: 'code',
      discount: 1,
    );
    selectionLoading.value = false;
  }

  void onSelectedPayment(PaymentMethod value) {
    selectionLoading.value = true;
    paymentMethod = value;
    paymentMethodText = value.name.capitalizeFirst;
    selectionLoading.value = false;
  }

  void onSelectedDeliveryTime(DeliveryTime value, String title) {
    selectionLoading.value = true;
    deliveryTime = value;
    deliveryTimeText = title;
    selectionLoading.value = false;
  }

  void onPressedMakeOrder() {}

  void calculateOutputs() {
    if (deliveryLocation != null &&
        deliveryTime != null &&
        paymentMethod != null) {
      enableMainButton.value == true;
    }

    //update products price & count & total Price
  }
}
