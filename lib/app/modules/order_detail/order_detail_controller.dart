import 'dart:async';

import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:uuid/uuid.dart';

class OrderDetailController extends GetxController {
  final OrderRepo orderRepo = Get.find();
  late OrderApp order;

  RxBool loading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    loading.value = true;
    final args = Get.arguments;
    if (args == null) {
      throw Exception(
          "order_detail_controller.dart need an OrderApp object as GetX argument");
    }
    order = OrderApp.fromJson(args as Map<String, dynamic>);

    listenToOrderDetail(order.id);

    loading.value = false;
  }

  void listenToOrderDetail(String orderId) {
    orderRepo.readOrderDetailStream(orderId).listen(
      (event) {
        if (loading.isFalse) {
          loading.value = true;
        }
        order = event;
        loading.value = false;
      },
    );
  }

  // onPressedViewPhone() {
  //   final phone = order.orderBy.phone.phoneCleanUseCountryCode;
  //   final phoneUri = Uri.parse("tel:$phone");
  //   launchUrl(phoneUri);
  // }

  void onPressedViewMaps() {
    final latitude = order.delivery!.destination.latitude;
    final longitude = order.delivery!.destination.longitude;
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    ///intended use of deprecated method
    ///because known bug in new implementation launchUrl() that cause gmaps to open in webview
    // ignore: deprecated_member_use
    launch(url);
  }

  void onRateOrder(double result) async {
    loading.value = true;
    final uuid = const Uuid().v4();
    final rating = Rating(
      id: uuid,
      orderId: order.id,
      userId: order.orderBy.documentId,
      createdAt: DateTime.now(),
      rate: result,
    );

    await orderRepo.updateOrder(
      UpdateOrderRequest(
        orderApp: order.copyWith(
          rating: rating,
          status: OrderStatus.finished,
          lastUpdate: DateTime.now(),
        ),
      ),
    );
    loading.value = false;
  }

  void onPressedSeeTransferStatus(OrderApp order) {
      // WA admin that this store want to confirm a transfer payment
      // provide admin with order id, customer name, customer phone, order amount, request timestamp
      final adminPhone = AppRepo.adminPhone.phoneCleanUseCountryCode;
      final message = "*VERIFY TRANSFER*\n"
          "${order.id}\n\n"
          "${order.orderBy.name} - ${order.orderBy.phone.phoneCleanUseZero}\n"
          "${order.payment.amount.formatNumberToCurrency()}\n\n"
          "_${DateTime.now().EEEEddMMMyyyy} ${DateTime.now().HHmm}_\n";
      final waUri = Uri.parse('whatsapp://send?phone=$adminPhone&text=$message');
      launchUrl(waUri);
  }
}
