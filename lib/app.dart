import 'package:flutter/material.dart';
import 'package:tranqueiros/core/core.dart';

/// The app.
class TranqueirosApp extends StatelessWidget {
  /// The app constructor.
  const TranqueirosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tranqueiros',
      debugShowCheckedModeBanner: false,
      theme: TranqueirosAppTheme.theme,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
