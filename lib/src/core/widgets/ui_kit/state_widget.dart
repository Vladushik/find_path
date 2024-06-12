import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ErrorCustomWidget extends StatelessWidget {
  const ErrorCustomWidget({
    required this.error,
    super.key,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(error),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
