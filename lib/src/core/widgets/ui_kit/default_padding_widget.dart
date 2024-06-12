import 'package:flutter/material.dart';

class DefaultPaddingWidget extends StatelessWidget {
  const DefaultPaddingWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: child,
    );
  }
}
