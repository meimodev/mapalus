import 'package:flutter/material.dart';
import 'package:mapalus/data/models/order.dart';
import 'package:mapalus/shared/enums.dart';

class BuilderSwitchOrderStatus extends StatelessWidget {
  const BuilderSwitchOrderStatus({
    Key? key,
    required this.order,
    required this.placed,
    required this.accepted,
    required this.rejected,
    required this.finished,
  }) : super(key: key);

  final Order order;
  final Widget placed;
  final Widget accepted;
  final Widget rejected;
  final Widget finished;

  @override
  Widget build(BuildContext context) {
    switch (order.status) {
      case OrderStatus.accepted:
        return accepted;
      case OrderStatus.rejected:
        return rejected;
      case OrderStatus.finished:
        return finished;
      default:
        return placed;
    }
  }
}