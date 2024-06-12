import 'dart:collection';

import 'package:find_path/src/features/home/data/models/path_data_model.dart';

abstract interface class PathFinder {
  Future<List<Point>> findShortestPath(FieldData data);
}

class PathFinderImpl implements PathFinder {
  @override
  Future<List<Point>> findShortestPath(FieldData data) async {
    try {
      if (data.field.isEmpty) return [];
      final List<List<int>> directions = [
        [1, 0],
        [-1, 0],
        [0, 1],
        [0, -1],
        [1, 1],
        [-1, -1],
        [1, -1],
        [-1, 1]
      ];
      final int rows = data.field.length;
      final int cols = data.field[0].length;
      final Queue<List<Point>> queue = Queue();
      final Set<String> visited = {};

      queue.add([data.start]);
      visited.add('${data.start.x},${data.start.y}');

      while (queue.isNotEmpty) {
        final List<Point> path = queue.removeFirst();
        final Point current = path.last;

        if (current.x == data.end.x && current.y == data.end.y) {
          return path;
        }

        for (final direction in directions) {
          final int newX = current.x + direction[0];
          final int newY = current.y + direction[1];
          if (newX >= 0 &&
              newX < cols &&
              newY >= 0 &&
              newY < rows &&
              data.field[newY][newX] == '.' &&
              !visited.contains('$newX,$newY')) {
            final List<Point> newPath = List.from(path);
            newPath.add(Point(x: newX, y: newY));
            queue.add(newPath);
            visited.add('$newX,$newY');
          }
        }
      }
      return [];
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
