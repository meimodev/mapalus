import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapalus/app/widgets/button_altering.dart';
import 'package:mapalus/app/widgets/button_main.dart';
import 'package:mapalus_flutter_commons/models/models.dart';
import 'package:mapalus_flutter_commons/repos/repos.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';
import 'package:mapalus_flutter_commons/widgets/widgets.dart';

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
  bool productNotFound = false;

  final productRepo = Get.find<ProductRepo>();
  final partnerRepo = Get.find<PartnerRepo>();
  final orderRepo = Get.find<OrderRepo>();

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
    if (product == null) {
      setState(() {
        loading = false;
        productNotFound = true;
      });
      return;
    }
    partner = await partnerRepo.getPartners(
      GetPartnerRequest(
        partnerId: product!.partnerId,
      ),
    );
    setState(() {
      loading = false;
    });
  }

  void onAddProductOrder(ProductOrder value) async {
    widget.onAddProductOrder(value);
    final productOrders = await orderRepo.readLocalProductOrders();
    // check if the product to be added from the same partner,
    // if not the same then reject the adding process and show a message
    final hadAnotherPartner = productOrders
            .indexWhere((e) => e.product.partnerId != value.product.partnerId) >
        -1;

    if (hadAnotherPartner) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: BaseColor.primary3,
            content: Text(
              "Pesananan hanya bisa dari satu PARTNER",
              style: BaseTypography.bodyMedium.toBlack,
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(
              horizontal: BaseSize.w12,
              vertical: BaseSize.h24,
            ),
          ),
        );
      }
      return;
    }

    // check if the product to be added from the same partner,
    // if not the same then reject the adding process and show a message

    final existIndex = productOrders.indexWhere(
      (element) => element.product.id == value.product.id,
    );

    if (existIndex > -1) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: BaseColor.primary3,
            content: Text(
              "Produk sudah ada, menambahkan jumlah",
              style: BaseTypography.bodyMedium.toBlack,
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(
              horizontal: BaseSize.w12,
              vertical: BaseSize.h24,
            ),
          ),
        );
      }
      final existProduct = productOrders.elementAt(existIndex).product;
      orderRepo.updateLocalProductOrders(productOrders
          .map(
            (e) => e.product.id == existProduct.id
                ? e.copyWith(
                    quantity: e.quantity + value.quantity,
                    totalPrice: (e.quantity + value.quantity) * e.product.price,
                  )
                : e,
          )
          .toList());
      return;
    }
    productOrders.add(value);
    orderRepo.updateLocalProductOrders(productOrders);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: LoadingWrapper(
        loading: loading,
        size: BaseSize.w48,
        child: productNotFound
            ? SizedBox(
                height: BaseSize.customHeight(200),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: BaseSize.w24,
                    vertical: BaseSize.h24,
                  ),
                  child: Center(
                    child: Text(
                      "Produk telah dihapus partner\n -_-",
                      textAlign: TextAlign.center,
                      style: BaseTypography.bodyLarge.w400,
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: BaseSize.w24,
                  vertical: BaseSize.h24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: BaseColor.accent,
                        borderRadius: BorderRadius.circular(BaseSize.radiusSm),
                      ),
                      height: BaseSize.customWidth(280),
                      child: product == null
                          ? const SizedBox()
                          : CustomImage(
                              imageUrl: product!.image,
                              fit: BoxFit.cover,
                            ),
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
                          "${product?.price.formatNumberToCurrency()} / ${product?.unit?.name}",
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
                          "$quantity ${product?.unit?.name ?? ""}",
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
