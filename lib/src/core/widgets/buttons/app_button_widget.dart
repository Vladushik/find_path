import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.isValid = true,
    super.key,
  });

  final String title;
  final void Function() onPressed;
  final bool isLoading;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid
            ? () {
                if (isLoading) return;
                if (isValid) {
                  onPressed();
                }
              }
            : null,
        child: isLoading ? const _LoadingWidget() : Text(title),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 3,
    );
  }
}
