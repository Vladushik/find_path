import 'package:dio/dio.dart';
import 'package:find_path/src/core/utils/path_finder.dart';
import 'package:find_path/src/features/home/bloc/home_bloc.dart';
import 'package:find_path/src/features/home/data/datasources/home_remote_data_source.dart';
import 'package:find_path/src/features/home/data/repositories/home_repository.dart';
import 'package:find_path/src/features/splash/bloc/splash_bloc.dart';
import 'package:find_path/src/features/splash/data/repositories/splash_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //MARK: - BLoCs
  sl.registerFactory(() => SplashBloc(repository: sl()));
  sl.registerFactory(() => HomeBloc(repository: sl()));
  //MARK: - Repositories
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        remoteDataSource: sl(),
        pathFinder: sl(),
      ));
  //MARK: - Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dio: sl()));
  //MARK: - Utils
  sl.registerLazySingleton<PathFinder>(() => PathFinderImpl());
  //MARK: - External
  final dio = Dio();
  sl.registerLazySingleton(() => dio);
}
