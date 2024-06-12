import 'dart:async';

import 'package:flutter/material.dart';

class PercentIndicatorWidget extends StatefulWidget {
  const PercentIndicatorWidget({
    required this.isFinished,
    super.key,
  });

  final bool isFinished;

  @override
  State<PercentIndicatorWidget> createState() => _PercentIndicatorWidgetState();
}

class _PercentIndicatorWidgetState extends State<PercentIndicatorWidget> {
  @override
  void didUpdateWidget(PercentIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFinished != oldWidget.isFinished) {
      isFinished = widget.isFinished;
    }
  }

  bool isFinished = false;
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        if (isFinished) {
          _progress = 1.0;
          _timer?.cancel();
        }
        _progress += 0.01;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${(_progress * 100).toStringAsFixed(0)}%'),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            value: _progress,
            strokeWidth: 3,
          ),
        ),
      ],
    );
  }
}
