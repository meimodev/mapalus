import 'dart:async';

import 'package:get/get.dart';
import 'package:mapalus/app/modules/home/home/home_controller.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class CartController extends GetxController {
  final orderRepo = Get.find<OrderRepo>();
  final userRepo = Get.find<UserRepo>();

  RxList<ProductOrder> productOrders = <ProductOrder>[].obs;
  RxBool isCardCartVisible = false.obs;
  var count = "".obs;
  var weight = "".obs;
  var price = "".obs;
  var note = "".obs;

  StreamSubscription<List<ProductOrder>?>? streamLocalProductOrders;

  bool forceRebuild = false;

  @override
  void onInit() async {
    super.onInit();

    final stream = orderRepo.exposeLocalProductOrders();
    streamLocalProductOrders ??= stream.listen((data) async {
      if (data != null) {
        // FOR SOME REASON THE UI FAILED TO REBUILT WHEN data is assigned to productOrders
        if (forceRebuild) {
          productOrders.value = [];
          await Future.delayed(const Duration(milliseconds: 300));
          forceRebuild = false;
        }
        productOrders.value = data;
        _calculateInfo();

        if (productOrders.isEmpty) {
          orderRepo.updateLocalNote('');
          Get.back();
        }
      }
    });

    //init data
    orderRepo.updateLocalProductOrders(
      await orderRepo.readLocalProductOrders(),
    );

    note.value = await orderRepo.readLocalNote();
  }

  @override
  void dispose() async {
    if (streamLocalProductOrders != null) {
      await streamLocalProductOrders!.cancel();
      streamLocalProductOrders = null;
    }
    super.dispose();
  }

  void onPressedSetDelivery() async {
    final user = await userRepo.getSignedUser();
    if (user == null) {
      final result = await Get.toNamed(Routes.signing);
      if (result == null || result == false) {
        return;
      }

      final homeController = Get.find<HomeController>();
      homeController.notifyUserHasChanged();
    }

    Get.toNamed(Routes.orderSummary);
  }

  void onPressedItemDelete(ProductOrder productOrder) {
    forceRebuild = true;
    final newOrders = List.of(productOrders);
    newOrders.remove(productOrder);
    orderRepo.updateLocalProductOrders(newOrders);
    _calculateInfo();
  }

  void onChangedNote(String note) {
    orderRepo.updateLocalNote(note);
    this.note.value = note;
  }

  void onChangedQuantity(ProductOrder altered) {
    orderRepo.updateLocalProductOrders(productOrders.map((element) {
      if (element.product.id == altered.product.id) {
        return altered;
      }
      return element;
    }).toList());
    _calculateInfo();
  }

  void _calculateInfo() {
    int count = 0;
    double weight = 0;
    double price = 0;

    // maybe take from the local store instead?
    for (var element in productOrders) {
      count++;
      weight += element.quantity * element.product.weight;
      price += element.quantity * element.product.price;
    }
    this.count.value = "$count Produk ";
    this.weight.value = weight > 0 ? weight.toKilogram() : "-";
    this.price.value = price.formatNumberToCurrency();
  }
}
