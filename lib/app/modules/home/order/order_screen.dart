import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/shared/routes.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderRepo orderRepo = Get.find<OrderRepo>();
  final UserRepo userRepo = Get.find<UserRepo>();

  List<OrderApp> orders = [];
  bool loading = true;

  UserApp? signedUser;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
    signedUser = (await userRepo.getSignedUser());
    if (signedUser == null) {
      setState(() {
        loading = false;
      });
      return;
    }
    orders = await orderRepo.readOrders(
      GetOrdersRequest(userApp: signedUser),
    );
    orders.sort((a, b) => b.createdAt.millisecondsSinceEpoch
        .compareTo(a.createdAt.millisecondsSinceEpoch));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.only(
        left: BaseSize.w12,
        right: BaseSize.w12,
        top: BaseSize.h24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Orders",
            textAlign: TextAlign.center,
            style: BaseTypography.displayLarge.bold.toPrimary,
          ),
          Gap.h24,
          LoadingWrapper(
            loading: loading,
            child: orders.isEmpty
                ? signedUser != null
                    ? Text(
                        "Tidak Ada Pesanan -_-",
                        style: BaseTypography.bodyMedium,
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "Masuk ke akun untuk melihat pesanan",
                        textAlign: TextAlign.center,
                        style: BaseTypography.bodyMedium,
                      )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    separatorBuilder: (context, index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Gap.h6,
                        Container(
                          color: BaseColor.black.withOpacity(.125),
                          height: 1,
                        ),
                        Gap.h6,
                      ],
                    ),
                    itemBuilder: (context, index) => CardOrder(
                      order: orders[index],
                      onPressed: () async {
                        await Get.toNamed(
                          Routes.orderDetail,
                          arguments: orders[index].toJson(),
                        );
                        await Future.delayed(const Duration(seconds: 1));
                        fetchOrders();
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
