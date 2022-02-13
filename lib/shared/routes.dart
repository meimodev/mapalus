import 'package:flutter/material.dart';
import 'package:mapalus/app/modules/account_settings/account_settings_screen.dart';
import 'package:mapalus/app/modules/cart/cart_screen.dart';
import 'package:mapalus/app/modules/home/home_screen.dart';
import 'package:mapalus/app/modules/location/location_screen.dart';
import 'package:mapalus/app/modules/order_detail/order_detail_screen.dart';
import 'package:mapalus/app/modules/ordering/ordering_screen.dart';
import 'package:mapalus/app/modules/orders/orders_screen.dart';
import 'package:mapalus/app/modules/signin/signing_screen.dart';
import 'package:mapalus/app/modules/splash/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String accountSetting = '/account-setting';
  static const String orders = '/orders';
  static const String orderDetail = '/order-detail';
  static const String cart = '/cart';
  static const String location = '/location';
  static const String ordering = '/ordering';
  static const String signing = '/signing';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case accountSetting:
        return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case orderDetail:
        return MaterialPageRoute(builder: (_) => const OrderDetailScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case location:
        return MaterialPageRoute(builder: (_) => const LocationScreen());
      case ordering:
        return MaterialPageRoute(builder: (_) => const OrderingScreen());
      case signing:
        return MaterialPageRoute(builder: (_) => const SigningScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}