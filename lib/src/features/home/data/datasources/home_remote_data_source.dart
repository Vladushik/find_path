import 'package:dio/dio.dart';
import 'package:find_path/src/core/network/logger_interceptor.dart';
import 'package:find_path/src/core/network/network_config.dart';
import 'package:find_path/src/features/home/data/models/models.dart';

abstract interface class HomeRemoteDataSource {
  Future<PathDataModel> getData(String url);
  Future<void> postPath(List<PathRequestModel> pathRequestModel);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<PathDataModel> getData(String url) async {
    try {
      dio.interceptors.add(LoggerInterceptor());

      final response = await dio.get(
        '${NetworkConfig.apiUrl}/flutter/api',
      );
      if (response.statusCode == 200) {
        return PathDataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load');
      }
    } on DioException catch (e) {
      throw Exception('${e.response?.statusCode}');
    } catch (e) {
      throw Exception('Unknown error');
    }
  }

  @override
  Future<void> postPath(List<PathRequestModel> pathRequestModel) async {
    try {
      dio.interceptors.add(LoggerInterceptor());

      final response = await dio.post(
        '${NetworkConfig.apiUrl}/flutter/api',
        data: pathRequestModel.map((user) => user.toJson()).toList(),
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load');
      }
    } on DioException catch (e) {
      throw Exception('${e.response?.statusCode}');
    } catch (e) {
      throw Exception('Unknown error');
    }
  }
}
