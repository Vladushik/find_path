import 'package:find_path/src/features/error/presentation/error_screen.dart';
import 'package:find_path/src/features/home/data/models/models.dart';
import 'package:find_path/src/features/home/presentation/home_screen.dart';
import 'package:find_path/src/features/preview/presentation/preview_screen.dart';
import 'package:find_path/src/features/process/presentation/process_screen.dart';
import 'package:find_path/src/features/result_list/presentation/result_list_screen.dart';
import 'package:find_path/src/features/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

enum AppPages {
  splash('/'),

  home('/home'),
  process('/process'),
  resultList('/result-list'),
  preview('preview');

  const AppPages(this.path);
  final String path;
}

sealed class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: AppPages.splash.path,
    errorBuilder: (_, state) => ErrorScreen(error: state.error?.message),
    routes: [
      GoRoute(
        path: AppPages.splash.path,
        name: AppPages.splash.name,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppPages.home.path,
        name: AppPages.home.name,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: AppPages.process.path,
        name: AppPages.process.name,
        builder: (_, __) => const ProcessScreen(),
      ),
      GoRoute(
        path: AppPages.resultList.path,
        name: AppPages.resultList.name,
        builder: (_, __) => const ResultListScreen(),
        routes: [
          GoRoute(
            path: AppPages.preview.path,
            name: AppPages.preview.name,
            builder: (context, state) {
              final List<Point> points = state.extra as List<Point>;
              return PreviewScreen(points: points);
            },
          ),
        ],
      ),
    ],
  );
}
