import 'package:get/get.dart';
import 'package:mapalus/app/modules/modules.dart';

class Routes {
  static const String home = '/';
  static const String accountSetting = '/account-setting';
  static const String orders = '/orders';
  static const String orderDetail = '/order-detail';
  static const String cart = '/cart';
  static const String location = '/location';
  static const String ordering = '/ordering';
  static const String orderSummary = '/order_summary';
  static const String signing = '/signing';
  static const String updateApp = '/update-app';
  static const String payment = '/payment';

  static const String grocery = '/grocery';
  static const String food = '/food';
  static const String laundry = '/laundry';

  static const String search = '/search';

  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case splash:
  //       return MaterialPageRoute(builder: (_) => const SplashScreen());
  //     case home:
  //       return MaterialPageRoute(builder: (_) => const HomeScreen());
  //     case accountSetting:
  //       return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
  //     case orders:
  //       return MaterialPageRoute(builder: (_) => const OrdersScreen());
  //     case orderDetail:
  //       return MaterialPageRoute(builder: (_) => const OrderDetailScreen());
  //     case cart:
  //       return MaterialPageRoute(builder: (_) => const CartScreen());
  //     case location:
  //       return MaterialPageRoute(builder: (_) => const LocationScreen());
  //     case ordering:
  //       return MaterialPageRoute(builder: (_) => const OrderingScreen());
  //     case signing:
  //       return MaterialPageRoute(builder: (_) => const SigningScreen());
  //     default:
  //       return MaterialPageRoute(builder: (_) => const HomeScreen());
  //   }
  // }

  static List<GetPage> getRoutes() {
    return [
      GetPage(
        name: home,
        page: () => const MainHomeScreen(),
        binding: MainHomeBinding(),
        transition: Transition.fade,
        maintainState: true,
        preventDuplicates: true,
      ),
      GetPage(
        name: accountSetting,
        page: () => const AccountSettingsScreen(),
        binding: AccountSettingsBinding(),
        // transition: Transition.cupertino,
      ),
      GetPage(
        name: orders,
        page: () => const OrdersScreen(),
        binding: OrdersBinding(),
        // transition: Transition.cupertino,
      ),
      GetPage(
        name: orderDetail,
        page: () => const OrderDetailScreen(),
        // transition: Transition.cupertino,
        binding: OrderDetailBinding(),
      ),
      GetPage(
        name: cart,
        page: () => const CartScreen(),
        binding: CartBinding(),
        transition: Transition.rightToLeft,
        maintainState: false,
      ),
      GetPage(
        name: location,
        page: () => const LocationScreen(),
        binding: LocationBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: ordering,
        page: () => const OrderingScreen(),
        binding: OrderingBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: signing,
        page: () => const SigningScreen(),
        binding: SigningBinding(),
        transition: Transition.leftToRight,
      ),
      GetPage(
        name: updateApp,
        page: () => const UpdateAppScreen(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: payment,
        page: () => const PaymentScreen(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: grocery,
        page: () => const GroceryScreen(),
        binding: GroceryBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: food,
        page: () => const FoodScreen(),
        binding: FoodBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: laundry,
        page: () => const LaundryScreen(),
        binding: LaundryBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: search,
        page: () => const SearchScreen(),
        binding: SearchBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: orderSummary,
        page: () => const OrderSummaryScreen(),
        binding: OrderSummaryBinding(),
      ),
    ];
  }
}

class RouteParamArgs {
  final Map<String, dynamic> passingData;

  const RouteParamArgs({required this.passingData});
}

class RouteParamArgsKey {
  static const String productOrders = "productOrders";
}
