import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({
    super.key,
    required this.loading,
    required this.child,
    this.size,
  });

  final bool loading;
  final Widget child;

  final double? size;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: loading
          ? Center(
              child: SizedBox(
                width: size,
                height: size,
                child: const CircularProgressIndicator(
                  color: BaseColor.primary3,
                ),
              ),
            )
          : child,
    );
  }
}
