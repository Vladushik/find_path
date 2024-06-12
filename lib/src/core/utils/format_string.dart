import 'package:find_path/src/features/home/data/models/path_data_model.dart';

abstract final class FormatString {
  static String formatPath(List<Point> path) {
    return path.map((point) => '(${point.x},${point.y})').join('->');
  }
}
