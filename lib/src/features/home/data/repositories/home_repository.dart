import 'package:find_path/src/core/utils/format_string.dart';
import 'package:find_path/src/core/utils/path_finder.dart';
import 'package:find_path/src/features/home/data/datasources/home_remote_data_source.dart';
import 'package:find_path/src/features/home/data/models/models.dart';

abstract interface class HomeRepository {
  Future<PathDataModel> getData(String url);
  Future<List<List<Point>>> calculatePath(PathDataModel dataModel);
  Future<List<PathRequestModel>> createPostObject(PathDataModel dataModel);
  Future<void> postPath(List<PathRequestModel> pathRequestModel);
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeRemoteDataSource remoteDataSource,
    required PathFinder pathFinder,
  })  : _remoteDataSource = remoteDataSource,
        _pathFinder = pathFinder;

  final HomeRemoteDataSource _remoteDataSource;
  final PathFinder _pathFinder;

  @override
  Future<PathDataModel> getData(String url) async {
    return _remoteDataSource.getData(url);
  }

  @override
  Future<void> postPath(List<PathRequestModel> pathRequestModel) async {
    await _remoteDataSource.postPath(pathRequestModel);
  }

  @override
  Future<List<List<Point>>> calculatePath(PathDataModel dataModel) async {
    final List<List<Point>> result = [];
    for (final item in dataModel.data) {
      final List<Point> points = await _pathFinder.findShortestPath(item);
      result.add(points);
    }
    return result;
  }

  @override
  Future<List<PathRequestModel>> createPostObject(
    PathDataModel dataModel,
  ) async {
    final List<PathRequestModel> list = [];
    for (final item in dataModel.data) {
      final List<Point> points = await _pathFinder.findShortestPath(item);
      final PathRequestModel element = PathRequestModel(
        id: item.id,
        result: Result(
          steps: [
            for (final e in points) Step(x: e.x.toString(), y: e.y.toString()),
          ],
          path: FormatString.formatPath(points),
        ),
      );
      list.add(element);
    }
    return list;
  }
}
