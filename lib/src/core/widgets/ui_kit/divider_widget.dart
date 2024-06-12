import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    this.vp = 0,
    super.key,
  });

  final double vp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vp),
      child: const Divider(
        height: 0,
      ),
    );
  }
}
