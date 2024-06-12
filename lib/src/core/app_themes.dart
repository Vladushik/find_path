import 'package:flutter/material.dart';

sealed class AppThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(elevation: 0),
    );
  }
}
