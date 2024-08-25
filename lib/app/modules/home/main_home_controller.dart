import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';
import 'package:uuid/uuid.dart';

class MainHomeController extends GetxController {
  UserRepo userRepo = Get.find<UserRepo>();
  OrderRepo orderRepo = Get.find<OrderRepo>();
  ProductRepo productRepo = Get.find<ProductRepo>();
  AppRepo appRepo = Get.find<AppRepo>();

  DateTime? currentBackPressTime;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void onInit() async{
    super.onInit();

    //TODO dummy for signing
    await userRepo.signing(
      UserApp(
        uid: "From Firebase",
        id: "0011IBzDCkBsWlrlR8cz",
        phone: "081212341234",
        name: "Jhon Manembo",
        lastActiveTimeStamp: DateTime.now(),
        partnerId: "ssTneIKTUTtnb8L4dGWA",
        fcmToken: "1234",
        deviceInfo: "TEST DEVICE",
      ),
    );
  }

  void navigateTo(int index) {
    pageController.jumpToPage(
      index,
      // duration:const Duration(milliseconds: 400),
      // curve: Curves.easeIn,
    );
  }
}
