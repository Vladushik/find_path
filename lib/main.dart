import 'dart:async';
import 'dart:developer';

import 'package:find_path/src/core/app_bloc_observer.dart';
import 'package:find_path/src/core/app_routes.dart';
import 'package:find_path/src/core/app_themes.dart';
import 'package:find_path/src/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_path/src/core/injection_container.dart' as di;

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = AppBlocObserver();
    await di.init();
    runApp(const MyApp());
  }, (e, s) async {
    log(e.toString());
    log(s.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<HomeBloc>()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp.router(
          title: 'Path',
          theme: AppThemes.lightTheme,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child ?? const SizedBox.shrink(),
          ),
          routerConfig: AppRoutes.router,
        ),
      ),
    );
  }
}
