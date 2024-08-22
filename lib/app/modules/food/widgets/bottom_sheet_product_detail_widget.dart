import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/button_altering.dart';
import 'package:mapalus/app/widgets/button_main.dart';
import 'package:mapalus/app/widgets/loading_wrapper.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

import 'widgets.dart';

void showBottomSheetProductDetailWidget(
  BuildContext context,
  String productId,
  void Function(ProductOrder value)? onAddProductOrder,
) =>
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BottomSheetProductDetailWidget(
        productId: productId,
        onAddProductOrder: (value) {
          if (onAddProductOrder != null) {
            onAddProductOrder(value);
          }
        },
      ),
    );

class BottomSheetProductDetailWidget extends StatefulWidget {
  const BottomSheetProductDetailWidget({
    super.key,
    required this.productId,
    required this.onAddProductOrder,
  });

  final String productId;
  final void Function(ProductOrder value) onAddProductOrder;

  @override
  State<BottomSheetProductDetailWidget> createState() =>
      _BottomSheetProductDetailWidgetState();
}

class _BottomSheetProductDetailWidgetState
    extends State<BottomSheetProductDetailWidget> {
  int quantity = 1;
  Product? product;
  Partner? partner;
  bool loading = true;

  final ProductRepo productRepo = Get.find<ProductRepo>();
  final PartnerRepo partnerRepo = Get.find<PartnerRepo>();
  final OrderRepo orderRepo = Get.find<OrderRepo>();

  @override
  void initState() {
    super.initState();
    initProduct();
  }

  void initProduct() async {
    setState(() {
      loading = true;
    });
    product = await productRepo.readProduct(widget.productId);
    partner = await partnerRepo.readPartner(product!.partnerId);
    setState(() {
      loading = false;
    });
  }

  void onAddProductOrder(ProductOrder value) async {
    widget.onAddProductOrder(value);
    bool exist = false;
    final productOrders = await orderRepo.readLocalProductOrders()
      ..map((e) {
        if (e.product.id == value.product.id) {
          exist = true;
          final newQuantity = quantity + value.quantity;

          return e.copyWith(
            quantity: newQuantity,
            totalPrice: newQuantity * value.product.price,
          );
        }
        return e;
      });

    if (exist) {
      orderRepo.updateLocalProductOrders(productOrders);
      return;
    }
    productOrders.add(value);
    orderRepo.updateLocalProductOrders(productOrders);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: BaseSize.w24,
        vertical: BaseSize.h24,
      ),
      child: LoadingWrapper(
        loading: loading,
        size: BaseSize.w36,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: BaseColor.secondaryText,
                  borderRadius: BorderRadius.circular(BaseSize.radiusSm),
                ),
                height: BaseSize.customWidth(200),
              ),
              Gap.h24,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product?.name ?? "",
                    style: BaseTypography.bodyLarge.w400,
                  ),
                  Gap.h6,
                  Text(
                    "${product?.price.formatNumberToCurrency()} / ${product?.unit.name}",
                    style: BaseTypography.bodyLarge.bold,
                  ),
                  Gap.h24,
                  Text(
                    product?.description ?? '',
                    style: BaseTypography.titleLarge.w300.toSecondary,
                  ),
                ],
              ),
              Gap.h24,
              partner == null
                  ? const SizedBox()
                  : CardPartnerWidget(
                      partner: partner!,
                      onPressed: () {},
                    ),
              Gap.h24,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonAltering(
                    onPressed: () {
                      setState(() {
                        quantity--;
                      });
                    },
                    label: "-",
                    enabled: quantity > 1,
                    height: BaseSize.customWidth(30),
                    width: BaseSize.customWidth(30),
                  ),
                  Gap.w12,
                  Text(
                    "$quantity ${product?.unit.name ?? ""}",
                    style: BaseTypography.bodyMedium,
                  ),
                  Gap.w12,
                  ButtonAltering(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    label: "+",
                    height: BaseSize.customWidth(30),
                    width: BaseSize.customWidth(30),
                  ),
                ],
              ),
              Gap.h24,
              ButtonMain(
                title: "Tambah Pesanan",
                onPressed: () {
                  final res = ProductOrder(
                    product: product!,
                    quantity: quantity.toDouble(),
                    totalPrice: product!.price * quantity,
                  );

                  Navigator.pop(context);
                  onAddProductOrder(res);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
