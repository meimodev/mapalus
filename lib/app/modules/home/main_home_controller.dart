import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';

class MainHomeController extends GetxController {
  UserRepo userRepo = Get.find<UserRepo>();
  OrderRepo orderRepo = Get.find<OrderRepo>();
  ProductRepo productRepo = Get.find<ProductRepo>();
  AppRepo appRepo = Get.find<AppRepo>();

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void navigateTo(int index) {
    pageController.animateToPage(
      index,
      duration:const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }
}
