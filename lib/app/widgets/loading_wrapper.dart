import 'package:flutter/material.dart';
import 'package:mapalus_flutter_commons/shared/shared.dart';

class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({
    super.key,
    required this.loading,
    required this.child,
  });

  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: BaseColor.primary3,
              ),
            )
          : child,
    );
  }
}
