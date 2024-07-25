import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/mapalus_flutter_commons.dart';


class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: BaseSize.w24,
          right: BaseSize.w24,
        ),
        child: Column(
          children: [
            Text("Order Screen")
          ],
        ),
      ),
    );
  }
}


