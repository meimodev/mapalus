## Mapalus App API Reference

This document describes the public routes, modules, controllers, widgets, and top-level functions exposed by the app. It includes example usage where appropriate.

### Routing

Routes are defined in `lib/shared/routes.dart` via `GetPage` entries and exported constants on `Routes`:

- `Routes.home`: `/`
- `Routes.accountSetting`: `/account-setting`
- `Routes.orders`: `/orders`
- `Routes.orderDetail`: `/order-detail`
- `Routes.cart`: `/cart`
- `Routes.location`: `/location`
- `Routes.ordering`: `/ordering`
- `Routes.orderSummary`: `/order_summary`
- `Routes.signing`: `/signing`
- `Routes.updateApp`: `/update-app`
- `Routes.payment`: `/payment`
- `Routes.grocery`: `/grocery`
- `Routes.food`: `/food`
- `Routes.laundry`: `/laundry`
- `Routes.search`: `/search`

Example navigation:

```dart
Get.toNamed(Routes.cart);
```

### Entry Point

- `main()` initializes services and runs `MyApp`.
- `MyApp` builds `GetMaterialApp` with theme, routes (`Routes.getRoutes()`), and a fixed text scale.

File: `lib/main.dart`

### Modules

Modules and their bindings/controllers/screens are exported from `lib/app/modules/modules.dart`. The key modules include:

- Account Settings: `AccountSettingsBinding`, `AccountSettingsController`, `AccountSettingsScreen`
- Cart: `CartBinding`, `CartController`, `CartScreen`
- Grocery: `GroceryBinding`, `GroceryController`, `GroceryScreen`
- Home (Main & submodules): `MainHomeBinding`, `MainHomeController`, `MainHomeScreen`, `HomeController`, `HomeScreen`, `OrderController`, `OrderScreen`, `PromoController`, `PromoScreen`
- Food: `FoodBinding`, `FoodController`, `FoodScreen`
- Laundry: `LaundryBinding`, `LaundryController`, `LaundryScreen`
- Location: `LocationBinding`, `LocationController`, `LocationScreen`
- Order Detail: `OrderDetailBinding`, `OrderDetailController`, `OrderDetailScreen`
- Ordering: `OrderingBinding`, `OrderingController`, `OrderingScreen`
- Orders: `OrdersBinding`, `OrdersController`, `OrdersScreen`
- Order Summary: `OrderSummaryBinding`, `OrderSummaryController`, `OrderSummaryScreen`
- Payment: `PaymentBinding`, `PaymentController`, `PaymentScreen`
- Search: `SearchBinding`, `SearchController`, `SearchScreen`
- Signing: `SigningBinding`, `SigningController`, `SigningScreen`
- Splash: `SplashScreen`
- Update App: `UpdateAppScreen`

Most controllers extend `GetxController` and are bound via their corresponding `Bindings` for dependency injection with GetX.

### Public Top-Level Functions

- `Future<double?> showBottomSheetRate({ required BuildContext context })`
  - Shows a rating dialog and resolves with selected rating (0..5) or `null` if dismissed.
  - File: `lib/app/widgets/bottom_sheet_rate.dart`
  - Example:
    ```dart
    final rating = await showBottomSheetRate(context: context);
    if (rating != null) {
      // handle rating
    }
    ```

- `void showBottomSheetProductDetailWidget(BuildContext context, String productId, void Function(ProductOrder value)? onAddProductOrder)`
  - Shows a product detail bottom sheet; invokes `onAddProductOrder` when user adds an item.
  - File: `lib/app/modules/food/widgets/bottom_sheet_product_detail_widget.dart`
  - Example:
    ```dart
    showBottomSheetProductDetailWidget(context, product.id, (order) {
      // add ProductOrder to cart
    });
    ```

### Reusable Widgets (Barrel: `lib/app/widgets/widgets.dart`)

All widgets below are exported via the barrel and can be imported with:

```dart
import 'package:mapalus/app/widgets/widgets.dart';
```

- `BadgeNotification`
- `BottomSheetRateWidget`
- `BuilderSwitchOrderStatus`
- `ButtonAltering`
- `DeleteAccountButton`
- `ButtonMain`
- `ButtonMapalus`
- `CardCartItem`
- `CardCartPeak`
- `CardCategory`
- `CardDeliveryFee`
- `CardNavigation`
- `CardOrder`
- `CardOrderInfo`
- `CardPartner`
- `CardProduct`
- `CardSearchBar`
- `ChipCategory`
- `DialogAnnouncement`
- `DialogConfirm`
- `DialogItemDetail`
- `DialogRating`
- `GoogleMapWrapper`
- `IconProductStatus`
- `ImageWrapperWidget`
- `LogoMapalus`
- `LogoMeimo`
- `TextInputQuantity`

Widget usage generally follows standard Flutter patterns; consult each file under `lib/app/widgets/` for props and expected behaviors.

### Feature Widgets (Food module barrel)

Import:

```dart
import 'package:mapalus/app/modules/food/widgets/widgets.dart';
```

- `FoodScreenAppBar`
- `SliverListViewSeparated<T>`
  - Horizontal list with title and custom item/separator builders.
  - File: `lib/app/modules/food/widgets/sliver_list_view_separated.dart`
  - Example:
    ```dart
    SliverListViewSeparated<Item>(
      title: 'Popular',
      list: items,
      itemBuilder: (context, item, index) => MyCard(item: item),
      separatorBuilder: (context, index) => Gap.w12,
    )
    ```
- `BottomSheetProductDetailWidget`
- `CardPartnerWidget`

### Order Detail Widgets (Barrel)

Import:

```dart
import 'package:mapalus/app/modules/order_detail/widgets/widgets.dart';
```

- `CardOrderDetailItemProductWidget`
- `DeliveryInfoLayoutWidget`
- `NavigationBarCardWidget`
- `NoteCardWidget`
- `OrderDataCardWidget`
- `PaymentInfoLayoutWidget`

### Home Widgets (Barrel)

Import:

```dart
import 'package:mapalus/app/modules/home/widgets/widgets.dart';
```

- `BottomNavBar`
- `CardDeliveryAddress`
- `CardMenu`
- `CardUserInfoWidget`

### Order Summary Widgets (Barrel)

Import:

```dart
import 'package:mapalus/app/modules/order_summary/widgets/widgets.dart';
```

- `OrderSummaryCounterItemWidget`
- `CardItemSelectDeliveryTimeWidget`
- `CardItemSelectPaymentWidget`
- `CardOrderDeliveryTimeWidget`
- `CardOrderSummaryItemWidget`
- `DialogSelectDeliveryTimeWidget`
- `DialogSelectPaymentWidget`
- `DialogSelectVoucherWidget`

### Controllers

Controllers extend `GetxController` and are exposed through module exports. Typical usage inside a page/screen:

```dart
class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => ...);
  }
}
```

See individual controller files under each module for events like `onInit`, actions like `onPressed*`, and observable state.

### Typedefs

- `OnValueSelectedCallbackPaymentTypeDef`
- `OnValueSelectedCallbackDeliveryTimeTypeDef`
- `OnValueSelectedCallbackVoucherTypeDef`

These are used by selection dialogs in the Order Summary module.

### Notes

- Many UI primitives (theme, spacing, typography, services, repos, models) come from `mapalus_flutter_commons`. Refer to that package for their APIs.
- Assets are under `assets/` with fonts, icons, images, and vectors used by widgets.
