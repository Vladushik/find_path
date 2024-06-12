import 'package:find_path/src/core/resources/resources.dart';
import 'package:find_path/src/core/utils/format_string.dart';
import 'package:find_path/src/features/home/data/models/models.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({
    required this.points,
    super.key,
  });

  final List<Point> points;

  @override
  Widget build(BuildContext context) {
    final int maxX =
        points.map((point) => point.x).reduce((a, b) => a > b ? a : b) + 1;
    final int maxY =
        points.map((point) => point.y).reduce((a, b) => a > b ? a : b) + 1;
    final int itemCount = maxX * maxY;

    Color getPointColor(Point point) {
      if (points.isEmpty) return Colors.white;
      const int firstIndex = 0;
      final int lastIndex = points.length - 1;
      final int currentIndex = points.indexOf(point);
      if (currentIndex == firstIndex) return AppColors.startWayColor;
      if (currentIndex == lastIndex) return AppColors.endWayColor;
      if (currentIndex > firstIndex && currentIndex < lastIndex) {
        return AppColors.wayColor;
      }
      return AppColors.white;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: CustomScrollView(
        slivers: [
          SliverGrid.builder(
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: maxX,
            ),
            itemBuilder: (context, index) {
              final int row = index ~/ maxX;
              final int col = index % maxX;
              points.any((point) => point.x == col && point.y == row);
              final Point point = points.firstWhere(
                  (point) => point.x == col && point.y == row,
                  orElse: () => Point(x: -1, y: -1));
              return _ItemWidget(
                text: '{$col,$row}',
                color: getPointColor(point),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Center(child: Text(FormatString.formatPath(points))),
          ),
        ],
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(),
      ),
      child: Center(child: Text(text)),
    );
  }
}
